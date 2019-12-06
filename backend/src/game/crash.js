var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var bodyParser = require('body-parser');
var crypto = require('crypto');
var rn = require('random-number');
var request = require('request');
var config = require('../config');
var mysql = require('mysql');

app.use(bodyParser.json());
///////////// constant from main server
var gameId = 1, next_gameId = 0, status = 0, firstTimerHandler, bet_max_limit = 100000, bet_min_limit = 1000, jackpot = 40778217, max_payout = 50000000, promo = true;
var profit_rate = [];
////////////
var timeInterval = 10, resetGameTime = 0, stopGameG = false;
var game_play_list = [], bots_list = [], cashout_list = [], socket_list = [];
var startTime = Date.now(), globalVariable = 0, elapsed_time = 0;
var crash = 283, hash = 'This is our server seed and how do you think our server seed , can you give me your opinion?';
var clientSeed = '000000000000000007a9a31ff7f07463d91af6b5454241d5faf282e5e0fe1b3a';
var tick;
//generate hash and get crash from hash
var genGameHash = function (serverSeed) {
	return crypto.createHash('sha256').update(serverSeed).digest('hex');
};

function run_query(query, success, fail, 
	// params = {},
	is_select = true) {
	var after_query;
	if (is_select) {
		after_query = function (err, rows, fields) {
			if (err) {
				fail();
				throw err;
			}
			// params.rows = rows;
			// success(params);
			success(row);
		}
	} else {
		after_query = function (err, result) {
			if (err) {
				fail();
				throw err;
			}
			if (!result) {
				fail();
			} else {
				success();
			}
		}
	}

	con.query(query, after_query);
}

function gameResult(seed, salt) {
	const nBits = 52 // number of most significant bits to use
	// 1. HMAC_SHA256(key=salt, message=seed)
	const hmac = crypto.createHmac("sha256", salt)
	hmac.update(seed)
	seed = hmac.digest("hex")

	// 2. r = 52 most significant bits
	seed = seed.slice(0, nBits / 4)
	const r = parseInt(seed, 16)

	// 3. X = r / 2^52
	let X = r / Math.pow(2, nBits) // uniformly distributed in [0; 1)

	// 4. X = 99 / (1-X)
	X = 99 / (1 - X)

	// 5. return max(trunc(X), 100)
	const result = Math.floor(X)
	return Math.max(1, result / 100)
}

//
app.post('/set_config', function (req, res) {
	bet_min_limit = req.body.bet_min_limit;
	bet_max_limit = req.body.bet_max_limit;
	max_payout = req.body.max_payout;
	profit_rate = req.body.profit_rate;
	res.json({ "status": true });
});

////////////////////////////
var con;
function handleDisconnect() {
	con = mysql.createConnection(config.mysql);
	con.connect(function (err) {
		if (err) {
			//console.log('error when connecting to db:' , err);
			setTimeout(handleDisconnect, 2000);
		}
	});

	con.on('error', function (err) {
		//console.log('db error' , err);
		if (err.code == 'PROTOCOL_CONNECTION_LOST')
			handleDisconnect();
		else
			throw err;
	});
}
handleDisconnect();
//////////////////////////////

// initialize game ...
function init() {
	var fail = function () {
		stopGameG = true;
		console.log('failed on init func');
	}

	var get_profit = function () {
		run_query('select `FROM`, `TO`, PERCENT from crash_game_profit',
			// success
			function (rows) {
				if (rows.length > 0) {
					profit_rate = rows[0];
					get_bots();
				}
			},
			// fail
			fail
		);
	}

	function get_bots() {
		run_query(
			'select * from crash_game_bot where ENABLE = 1',
			function (rows) {
				bots_list = rows;
				get_current_game();
			},
			fail
		);
	}

	function get_current_game() {
		run_query('select GAMENO from crash_game_total where STATE = "WAITING"',
			function (rows) {
				if (rows.length > 0) {
					// get player list and send them to every socket...
					gameId = rows[0].GAMENO;
					current_game_players(gameId);
				} else {
					// create new game and ...
					new_game();
				}
			},
			fail
		);
	}

	function current_game_players(game_id) {
		run_query(
			'select * from crash_game_log where GAMENO = ' + game_id,
			function (rows) {
				game_play_list = rows;
			},
			fail
		);
	}

	function new_game() {
		// make new game on db, send it back ...
		con.query(
			'insert into crash_game_total ',
			function () {
				// notice ...
			},
			fail,
			true // not select
		)
	}

	// it starts with loading profit game rate
	get_profit();
}

function generateBustValue(currentHash) {
	currentHash = genGameHash(currentHash);
	finalBust = Math.floor(gameResult(clientSeed, currentHash) * 100);
	return { "hash": currentHash, "crash": finalBust };
}

io.on('connection', function (socket) {
	// console.log('a new user connected');
	var i;

	if (globalVariable == 0) {
		clearInterval(firstTimerHandler);
		next_gameId = gameId;
		waitGame();
	} else {
		// send socket current game status
		if (status == 2) {
			// when game is waiting
			socket.emit('onMessage', {
				code: 'WaitGame',
				current_users: game_play_list,
				game_id: gameId,
				time_left: (resetGameTime + 5000 - Date.now())
			});
		} else if (status == 3) {
			// when game started
			// we send current game id, next game id (for bet)
			socket.emit('onMessage', {
				code: 'GameStart',
				game_id: gameId,
				tick: tick
			});
			// we send who's the game players bet
			socket.emit('onMessage', {
				code: 'ReloadPlayers',
				current_users: game_play_list,
				cashout_list: cashout_list
			});
		} else if (status == 4) {
			// when game crashed ... 
			// we do nothing here, just wait for next game, it won't take more than 3 seconds
			// we should change if you want to show something. ^0^
		}
	}

	globalVariable = 1;

	socket.on('disconnect', function () {
		for (i = 0; i < socket_list.length; i++) {
			if (socket_list[i].id == socket.id) {
				socket_list.splice(i, 1);
				break;
			}
		}
	});

	function do_addbet(betInfo) {
		let user_id = betInfo.user_id;
		let game_id = betInfo.game_id;
		let bet_amount = betInfo.bet;
		let is_bot = betInfo.is_bot ? false : true;

		con.query('select * from crash_game_total where id = ' + game_id,
			function (err, rows, fields) {
				if (err) {
					stopGameG = true; throw err;
				}
				if (rows.length > 0) {
					// check game status
					if (rows[0].STATUS !== 'WAITING') {
						// response with error
					}
					if (!is_bot) {
						// update user wallet
						con.query('update users set WALLET_BLOCK = WALLET_BLOCK + ' + bet_amount + ', \
						WALLET_AVAILABLE = WALLET_AVAILABLE - ' + bet_amount + ' where id = ' + user_id,
							function (err, result) {
								if (err) {

								}
								if (!result) {

								}
							}
						);
					}
					// add bet info, update game bet amount
					con.query()
				} else {
					// invalid game id
				}
			}
		);

		socket.emit("onMessage", {
			code: 'BetResult',
			status: ret.status,
			error: ret.error
		});
		if (ret.status) {
			var betInfo = {
				bet: data.bet,
				user_id: data.user_id,
				name: data.user_name,
				avatar: data.avatar,
				option: 0,
				game_id: data.game_id,
				is_bot: '0',
				done: false,
				new: '1'
			};
			game_play_list.push(betInfo);
			io.emit(
				'onMessage',
				{
					code: 'ReloadPlayers',
					current_users: game_play_list,
					cashout_list: cashout_list
				}
			);
		}
	}

	function do_cashout(cashout, socket = null) {
		// cashout -- ?
		// check game status
		// then check cash_rate (smaller than bust)
		// finally, update everything
		var gameInfo;
		var res_err = function ( msg = 'Error occurred' ) {
			socket.emit('onMessage', {
				code: 'Cashout',
				status: false,
				error: msg
			});
		}

		var res_success = function () {
			if (socket) {
				socket.emit('onMessage',
				{
					code: 'Cashout',
					status: true
				});
			}
		}

		var check_game = function() {
			run_query('select STATE, BUST from crash_game_total where GAMENO = ' + cashout.gameNo,
				function(rows) {
					if (rows.length == 0) {
						res_err('Invalid Game No');
					} else {
						gameInfo = rows[0];
						if (gameInfo.STATE != 'STARTED') {
							res_err('Invaid game status');
						} else if (gameInfo.BUST < cashout.cash_rate) {
							res_err('Wrong cash rate');
						} else {
							bet_info();
						}
					}
				},
				res_err
			);
		};

		var bet_info = function() {
			run_query(
				'select ID, BET_AMOUNT, IS_BOT from crash_game_log where \
				USERID = ' + cashout.user_id + ' and IS_BOT = ' + (cashout.is_bot ? '1' : '0'),
				function (rows) {
					if (rows.length > 0) {
						var betInfo = rows[0];
						if (betInfo.CASHOUTRATE > 0) {
							res_err('Already cash out');
						}
						update_bet(betInfo);
					} else {
						res_err('No bets');
					}
				},
				fail
			)
		};

		var update_bet = function (betInfo) {
			var cashoutAmount = betInfo.BET_AMOUNT * cashout.cash_rate;
			run_query('UPDATE crash_game_log \
				SET `CASHOUTRATE` = ' + cashout.cash_rate + '\
				`CASHOUT` = ' + cashoutAmount + '\
				`PROFIT` = ' + (cashoutAmount - betInfo.BET_AMOUNT) + '\
				WHERE `ID` = ' + betInfo.ID,
				function ()	 {
					if (!cashout.is_bot) {
						update_user(betInfo);
					} else {
						res_success();
					}
				},
				res_err,
				false
			);
		}



		var update_user = function (betInfo) {
			var update_user_table = function (userInfo, betInfo) {
				con.query('UPDATE users SET \
					`WALLET` = \
					WHERE ID = ' + cashout.user_id,
					function(err, result) {
						if (err) {
							res_error('Error occurred');
							return;
						}
						if (result) {
							res_success();
						} else {
						}
					}
				);
			}
			
			// get user info
			con.query('SELECT WALLET, WALLET_AVAILABLE, WALLET_BLOCK FROM users WHERE ID = ' + cashout.user_id,
				function (err, result, fields) {
					if (err) {
						res_err('Error occurred');
						return;
					}
					if (rows.length > 0) {
						update_user_table(rows[0], betInfo);
					} else {
						res_error('Invalid user id');
					}
				}
			);
		}


		request.post(
			{
				url: mainServerUrl + 'ajax_cashout',
				formData: {
					game_no: gameId,
					user_id: cashout.user_id,
					cash_rate: cashout.stopped_at,
					is_bot: cashout.is_bot
				}
			},
			function (error, response, body) {
				var ret = JSON.parse(body);
				socket.emit('onMessage',
					{
						code: 'Cashout',
						status: ret.status,
						error: ret.error
					}
				);
				if (ret.status) {
					var cashout_player = false;
					for (var i = 0; i < game_play_list.length; i += 1) {
						if (game_play_list[i].new == '0'
							&& game_play_list[i].is_bot == '0'
							&& game_play_list[i].user_id == data.user_id) {
							// this user cashout
							cashout_player = game_play_list.splice(i, 1);
							break;
						}
					}
					if (cashout_player) {
						cashout_player = cashout_player[0];
						// we set them at the top
						cashout_player.option = data.stopped_at;
						cashout_player.done = true;
						cashout_list.push(cashout_player);
					}
					io.emit('onMessage',
						{
							code: 'ReloadPlayers',
							current_users: game_play_list,
							cashout_list: cashout_list,
							cur_cashout: cashout_player// user currently sent cashout message
						}
					);
				}
			}
		);
	}

	function do_bust(bustVal) {
		request.post({
			url: mainServerUrl + 'ajax_game_bust',
			formData: {
				hash_value: bustVal
			}
		}, function (error, response, body) {
			// console.log(body);
			var ret = JSON.parse(body);
			if (ret.status) {
				game_play_list = [];
				cashout_list = [];

				elapsed_time = 0;
				// wait for 3 seconds to show BUSTED VALUE
				setTimeout(function () {
					waitGame();
				}, 3000);

				io.emit('onMessage',
					{
						code: 'GameCrash',
						crash: crash
					}
				);
			} else {
				// no response //main server destroyed ... waiting request from main server.
				stopGameG = true;
			}
		});
	}

	socket.on('onMessage', function (data) {
		// this is where we process client - server communication
		switch (data.code) {
			//when you click bet button
			case 'addBet':
				do_addbet(data);
				break;
			//when you click cashout button
			case 'CashOut':
				if (data.stopped_at > tick) {
					// error
					socket.emit('onMessage',
						{
							code: 'Cashout',
							status: false,
							error: 'Cashrate is not valid'
						}
					);
					return;
				}
				do_cashout(data);
				break;
			// reload at first
			case 'Reload':
				// when new socket tries to connect
				// remove old socket, previously registered to socket_list
				var run_time = 0;
				if (status == 2) {
					run_time = Date.now() - resetGameTime;
				}

				obj = {
					'game_info': {
						'elapsed_time': elapsed_time,
						'game_id': gameId,
						'graph_colour': 1,
						'player_list': game_play_list,
						'run_time': run_time,
						'status': status
					},
					'code': 'GameInfo',
				}

				socket.emit('onMessage', obj);
				break;
			default:
				console.log('unknown code', data.code);
				break;
		}
	});

	// when socket first connnects, tell them about game rule, max/min limits, max_payout ...
	socket.emit('onMessage',
		{
			code: 'GameRule',
			bet_max_limit: bet_max_limit,
			bet_min_limit: bet_min_limit,
			max_payout: max_payout,
			promo: true,
		}
	);
});

function addBot(bot) {
	var bust_val, random_option;
	random_option = {
		min: parseInt(bot.BUST_FROM * 100),
		max: parseInt(bot.BUST_TO * 100),
		integer: true
	}
	bust_val = rn(random_option);
	var obj = {
		'user_id': bot.ID,
		'game_id': gameId,
		'type': 'manual',
		'name': bot.F_ID,
		'bet': parseInt(bot.BASE_VALUE),
		'cashoutrate': 0,
		'cashout': 0,
		'new': '1',
		'done': bust_val > crash ? true : false,
		'is_bot': '1',
		'bust': bust_val
	};

	do_addbet({
		user_id: obj.user_id,
		is_bot: obj.is_bot,
		bet: obj.bet
	});
}

function bust_start() {
	// we don't need to start game, because it finishes when it starts
	// we make exception for this case
	request.post(
		{
			url: mainServerUrl + 'ajax_game_finish_start',
			formData: {
				game_no: gameId, bust: crash
			}
		},
		function (eror, response, body) {
			var ret = JSON.parse(body);
			if (ret.status) {
				next_gameId = ret.next_game_no;
				cashout_list = [];
				game_play_list = [];
				status = 4;
				elapsed_time = 0;
				setTimeout(function () {
					waitGame();
				}, 3000);
				io.emit('onMessage',
					{
						code: 'GameStartCrash', // it means game crashes when it starts
						game_id: gameId,
						next_game_id: next_gameId,
						crash: crash // 100
					}
				);
			} else {
				stopGameG = true;
			}
		}
	);
}

function do_start(bustVal) {

	request.post(
		{
			url: mainServerUrl + "ajax_game_start",
			formData: {
				game_no: gameId,
				bust: bustVal
			}
		},
		function (error, response, body) {
			var ret = JSON.parse(body);
			if (ret.status) {
				next_gameId = ret.next_game_no;
				cashout_list = []; // clear cashout list
				startTime = Date.now();
				status = 3; resetGameTime = 0;
				// when game starts, all game_play_list becomes old
				for (var i = 0; i < game_play_list.length; i++) {
					game_play_list[i].new = '0';
				}

				setTimeout(function () {
					// console.log('timeout -- 200');
					elapsed_time = 0;
					startTime = Date.now();
					firstTimerHandler = setInterval(intervalFunc, timeInterval);
				}, 200);

				io.emit('onMessage',
					{
						code: 'GameStart',
						game_id: gameId,
						next_game_id: next_gameId,
						tick: 100, // we send 100 for tick
						// start_time: startTime
					}
				);

			} else {
				stopGameG = true;
			}
		}
	);
}

function startGame() {
	// when game starts, we calc crash value first
	crash_obj = generateBustValue(hash);
	crash = crash_obj['crash'];
	hash = crash_obj['hash'];
	if (crash == 100) {
		bust_start();
		return;
	}

	do_start(crash);
}

function intervalFunc() {
	elapsed_time = Date.now() - startTime;
	tick = Math.floor(100 * Math.pow(Math.E, 0.00006 * elapsed_time));
	io.emit('onMessage',
		{
			code: 'Tick',
			tick: tick,
			game_id: gameId
		}
	);

	// check for bot to be cashed out
	var old_len = game_play_list.length;
	for (var i = 0; i < game_play_list.length; i += 1) {
		if (game_play_list[i].is_bot == '0')
			continue;
		if (game_play_list[i].bust <= tick) {
			var cashout = game_play_list[i];
			// bot cashout ...
			do_cashout({
				user_id: cashout.user_id,
				game_id: cashout.game_id,
				cashout: cashout.bust,
				is_bot: 1
			});

			game_play_list.splice(i, 1); i -= 1;
			cashout.done = true;
			cashout.option = cashout.bust;
			cashout_list.push(cashout);
		}
	}

	if (old_len > game_play_list.length) {
		io.emit('onMessage',
			{
				code: 'ReloadPlayers',
				current_users: game_play_list,
				cashout_list: cashout_list,
				cur_cashout: cashout
			}
		);
	}

	var aftertick = Math.floor(100 * Math.pow(Math.E, 0.00006 * (elapsed_time + 200)));
	if (aftertick >= crash) {
		clearInterval(firstTimerHandler);
		status = 4;// game crashed
		do_bust(hhash);
	}
}

function waitGame() {
	// wait for 5 seconds to start new game
	// console.log('wait game');
	// start game after 5 seconds
	resetGameTime = Date.now();
	status = 2;
	gameId = next_gameId;
	next_gameId = 0;
	tick = 100; // start value
	// bots bet first
	var index = 0;
	for (var i = 0; i < bots_list.length; i += 1) {
		setTimeout(function () {
			addBot(bots_list[index]);
			index += 1;
		}, Math.random() * 4500);
	}
	io.emit('onMessage',
		{
			code: 'WaitGame',
			current_users: game_play_list,
			game_id: gameId,
			time_left: 5000
		}
	);
	setTimeout(function () {
		startGame();
	}, 5000);
}
/*
	api group
*/
app.use(function (req, res, next) {

	// Website you wish to allow to connect
	// res.setHeader('Access-Control-Allow-Origin', config.origin_header);
	// Request methods you wish to allow
	res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
	// Request headers you wish to allow
	res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
	// Set to true if you need the website to include cookies in the requests sent
	// to the API (e.g. in case you use sessions)
	res.setHeader('Access-Control-Allow-Credentials', true);
	// Pass to next layer of middleware
	next();
});

http.listen(config.crash_port, function () {
	console.log('listening on Crash server:' + config.crash_port);
});

init();