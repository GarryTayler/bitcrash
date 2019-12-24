var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var bodyParser = require('body-parser');
var crypto = require('crypto');
var rn = require('random-number');
var request = require('request');
var config = require('./src/config');
app.use(bodyParser.json());
///////////// constant from main server
var gameId = 1, next_gameId = 0, status = 0, firstTimerHandler, bet_max_limit = 100000, bet_min_limit = 1000, jackpot = 40778217, max_payout = 50000000, promo = true;
var mainServerUrl = config.main_host_url + 'crash/';
////////////
var timeInterval = 10, resetGameTime = 0, stopGameG = false;
var game_play_list = [], bots_list = [], cashout_list = [], socket_list = [];
var startTime = Date.now(), globalVariable = 0, elapsed_time = 0; prev_time = 0;
var crash = 283, hash = 'This is our server seed and how do you think our server seed , can you give me your opinion?';
var clientSeed = '000000000000000007a9a31ff7f07463d91af6b5454241d5faf282e5e0fe1b3a';
var tick;

// For wait time synchronize
var wait_time_left = 0;

//generate hash and get crash from hash
var genGameHash = function (serverSeed) {
	return crypto.createHash('sha256').update(serverSeed).digest('hex');
};
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
	res.json({ "status": true });
});

request.post(
    {
        url: mainServerUrl + 'init',
        form: {}
    },
    function (error, response, body) {
        var ret = JSON.parse(body);
        if (ret.status) {
            gameId = ret.game_no;
			if (ret.bots) bots_list = ret.bots;
			if (ret.game_player_list) game_play_list = ret.game_player_list;
		} else
			stopGameG = true;
	}
)

function generateBustValue(currentHash) 
{
	currentHash = genGameHash(currentHash);   
	finalBust = Math.floor(gameResult(clientSeed , currentHash) * 100);

	return {"hash": currentHash ,  "crash": finalBust};  
}

io.on('connection', function(socket){

	console.log('a new user connected');
	var i;

    if(globalVariable == 0) {
        clearInterval(firstTimerHandler);
		next_gameId = gameId;
        waitGame();
	} 
	else {
		// send socket current game status
		if (status == 2) {
			// when game is waiting
			socket.emit('onMessage', {
				code:'WaitGame',
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
		} 
		else if (status == 4) {
			// when game crashed ... 
			// we do nothing here, just wait for next game, it won't take more than 3 seconds
			// we should change if you want to show something. ^0^
		}
    }

    globalVariable = 1;

    socket.on('disconnect', function(){    
        for(i = 0; i < socket_list.length; i ++) {
            if(socket_list[i].id == socket.id) {
                socket_list.splice(i , 1);
                break;
            }
        }
    });

    socket.on('onMessage' , function(data) {
		// this is where we process client - server communication
        switch(data.code) {
            //when you click bet button
			case 'addBet':
				request.post({
                     url:    mainServerUrl + 'bet',
                    form: {
                        user_id : data.user_id,
                        game_no: data.game_id,
						bet : data.bet,
						is_bot : 0
                    }
                }, function(error, response, body){
					var ret = JSON. parse(body);
					socket.emit("onMessage" , {
						code: 'BetResult',
						status: ret.status,
						error: ret.error
					});
                    if (ret.status) {
                        var betInfo = {
							bet: parseInt(data.bet),
							user_id: data.user_id,
							name: data.user_name,
							avatar: data.avatar,
                            option: 0,
                            game_id: data.game_id,
                            is_bot: 0,
                            done: false,
							new: '1',
							profit: 0
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
                });
                break;
			//when you click cashout button
			case 'CashOut':
				if (data.stopped_at > tick) {
					// error
					socket.emit('onMessage',
						{
							code: 'Cashout',
							status: false,
							error: 'Cash Rate is not valid'
						}
					);
					return;
				}
                request.post(
                    {
                        url: mainServerUrl + 'cashout',
                        form: {
                            game_no: gameId,
                            user_id: data.user_id,
							cash_rate: data.stopped_at
                        }
                    },
                    function(error, response, body) {
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
                                    && game_play_list[i].is_bot == 0
                                    && game_play_list[i].user_id == data.user_id) {
                                    // this user cashout
                                    cashout_player = game_play_list.splice(i, 1);
                                    break;
                                }
                            }
                            if (cashout_player) {
                                cashout_player = cashout_player[0];
                                // we set them at the top
                                cashout_player.option = data.stopped_at * 100;
								cashout_player.done = true;
								cashout_player.cashout = parseFloat(data.stopped_at).toFixed(2).toString() + 'x';
								cashout_player.profit = parseFloat(data.stopped_at) * cashout_player.bet;
								cashout_list.push(cashout_player);
                            }
                            io.emit('onMessage',
                                {
                                    code: 'ReloadPlayers',
                                    current_users: game_play_list,
                                    cashout_list: cashout_list,
									cur_cashout: cashout_player
                                }
                            );
                        }
                    }
                );
                break;
            // reload at first
			case 'Reload':
                // when new socket tries to connect
                // remove old socket, previously registered to socket_list
                var run_time = 0;
                if(status == 2) {
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
                socket.emit('onMessage' , obj);
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
	var bust_val , random_option;
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
		'is_bot': 1,
		'bust': bust_val,
		'profit': 0 ,
		'avatar': bot.avatar
	};

	request.post({
		url: mainServerUrl + 'bet',
		form: {
			user_id: obj.user_id,
			game_no: obj.game_id,
			is_bot: obj.is_bot,
			bet: obj.bet
		}
	}, function (error, response, body) {
		var ret = JSON.parse(body);
		if (ret.status) {
			// bot added successfully ...
		} else {
			stopGameG = true;
		}
	});

	game_play_list.push(obj);
	io.emit("onMessage" ,
		{
			code: 'ReloadPlayers',
			current_users: game_play_list,
			cashout_list: []
		}
	);
}

function startGame() {
	// when game starts, we calc crash value first
	crash_obj = generateBustValue(hash);
	crash = crash_obj['crash'];
	hash = crash_obj['hash'];
	if (crash == 100) {

		// we don't need to start game, because it finishes when it starts
		// we make exception for this case
		request.post(
			{
				url: mainServerUrl + 'game_finish_start',
				form: {
					game_no: gameId, bust: crash
				}
			},
			function(eror, response, body) {
				var ret = JSON.parse(body);
				if (ret.status) {
					next_gameId = ret.next_game_no;
					cashout_list = [];
					game_play_list = [];
					status = 4;
					elapsed_time = 0;
					setTimeout(function() {
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
		return;
	}

	request.post(
		{
			url: mainServerUrl + "game_start",
			form: {
				game_no: gameId,
				bust: crash
			}
		},
		function(error, response, body) {
			var ret = JSON.parse(body);
			if (ret.status) {
				next_gameId = ret.next_game_no;
				cashout_list = []; // clear cashout list
				startTime = Date.now();
				status = 3; resetGameTime = 0;
				// when game starts, all game_play_list becomes old
				for(var i = 0; i < game_play_list.length; i ++ ) {
					game_play_list[i].new = '0';
				}
				setTimeout(function() {
					elapsed_time = 0;
					startTime = Date.now();
					firstTimerHandler = setInterval(intervalFunc, timeInterval);
				} , 200);
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
function intervalFunc()
{
	elapsed_time = Date.now() - startTime;
	tick = Math.floor(100 * Math.pow(Math.E, 0.00006 * elapsed_time));
	if (elapsed_time - prev_time > 1000) {
		io.emit('onMessage',
			{
				code: 'Tick',
				tick: tick,
				game_id: gameId
			}
		);
		prev_time = elapsed_time
	}
	// check for bot to be cashed out
	var old_len = game_play_list.length;
	for (var i = 0; i < game_play_list.length; i += 1) {
		if (game_play_list[i].is_bot == 0) 
			continue;
		if (game_play_list[i].bust <= tick) {
			var cashout = game_play_list[i];
			// bot cashout ...
			request.post({
				url: mainServerUrl + 'cashout',
				form: {
					user_id: cashout.user_id,
					game_no: cashout.game_id,
					cash_rate: parseFloat(cashout.bust / 100).toFixed(2),
					is_bot: 1
				}
			}, function(error, response, body) {
				var ret = JSON.parse(body);
				if (ret.status) {
					// server side done ...
				} else {
					stopGameG = true;
				}
			});
			game_play_list.splice(i, 1); i -= 1;
			cashout.done = true;
			cashout.option = cashout.bust;
			cashout.cashout = parseFloat(cashout.bust / 100).toFixed(2).toString() + 'x';
			cashout.profit = parseFloat(cashout.bust / 100) * cashout.bet;
			cashout_list.push(cashout);
		}
	}

	if (old_len > game_play_list.length) {
		io.emit('onMessage',
			{
				code: 'ReloadPlayers',
				current_users: game_play_list,
				cashout_list: cashout_list
			}
		);
	}

	var aftertick = Math.floor(100 * Math.pow(Math.E, 0.00006 * (elapsed_time + 200)));
	if(aftertick >= crash) {
		clearInterval(firstTimerHandler);
		status = 4;// game crashed
		request.post({
				url:    mainServerUrl + 'game_bust',
				form: {
					game_no: gameId,
					hash_value: hash
				}
		}, function(error, response, body){
			var ret = JSON.parse(body);
			if(ret.status) {
				game_play_list = [];
				cashout_list = [];
				elapsed_time = 0;
				// wait for 3 seconds to show BUSTED VALUE
				setTimeout(function() {
					waitGame();
				}, 3000);
				io.emit('onMessage',
					{
						code: 'GameCrash',
						crash: crash,
						game_no: gameId
					}
				);
			}
			else {
				// no response //main server destroyed ... waiting request from main server.
				stopGameG = true;
			}
		});
	}
}

function waitGame() {
	// start game after 5 seconds
	resetGameTime = Date.now();
	status = 2;
	gameId = next_gameId;
	next_gameId = 0;
	tick = 100; // start value
	// bots bet first
	var index = 0;
	for (var i = 0; i < bots_list.length; i += 1) {
		setTimeout(function() {
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
	//For wait time synchronize
	wait_time_left = 5000;
	setTimeout(function() {
		sendWaitTime();
	}, 500);

	setTimeout(function() {
		startGame();
	}, 5000);
}

//For wait time synchronize
function sendWaitTime() {
	wait_time_left -= 500;
	io.emit('onMessage',
		{
			code: 'WaitGameTick',
			current_users: game_play_list,
			game_id: gameId,
			tick: wait_time_left
		}
	);
	if(wait_time_left > 500)
	setTimeout(function() {
		sendWaitTime();
	}, 500);
}
/* api group */
app.use(function (req, res, next) {
	// Website you wish to allow to connect
	res.setHeader('Access-Control-Allow-Origin', "*");
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

http.listen(config.crash_port, function(){
	console.log('listening on *:' + config.crash_port);
});
