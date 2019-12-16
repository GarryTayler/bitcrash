
var db = require('./../../utils/database');
var dateFormat = require('dateformat');
var userModel = require('./user');

var bust_game = function (gameInfo) {
    // set game busted ---> because it has bust alrady
    var bustedBets = []
    db.cmd(db.statement('update', 'crash_game_total', "set " + db.lineClause(
        [{
            key: "STATE",
            val: "BUSTED"
        },
        {
            key: "BUSTEDTIME",
            val: dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss")
        }], ","), db.itemClause("ID", gameInfo.ID)))

    // updated users table ---
    return db.list(db.statement('select * from', 'crash_game_log', '', db.lineClause([
        {
            key: "IS_BOT",
            val: 0
        },
        {
            key: "GAMENO",
            val: gameInfo.GAMENO
        },
        {
            key: "CASHOUTRATE",
            val: 0
        }
    ], "and")), true).then((_bustedBets) => {
        db.cmd(db.statement('update', 'crash_game_log', "set " + db.itemClause("PROFIT", "PROFIT-BET_AMOUNT"), db.lineClause([
            {
                key: "GAMENO",
                val: gameInfo.GAMENO
            },
            {
                key: "CASHOUTRATE",
                val: 0
            }], "and")))
        bustedBets = _bustedBets
        // calc profit --> from crash_game_log
        return db.list(db.statement('select sum(PROFIT) as profit from', 'crash_game_log', '', db.lineClause([
            {
                key: "IS_BOT",
                val: 0
            },
            {
                key: "GAMENO",
                val: gameInfo.GAMENO
            }
        ], "and")), true)
    }).then((profit) => {
        if (profit.length > 0) {
            db.cmd(db.statement('update', 'crash_game_total', "set " + db.itemClause("PROFIT", -db.convFloat(profit[0].profit)), db.itemClause("GAMENO", gameInfo.GAMENO)))
        }
        for (var i = 0; i < bustedBets.length; i++) {
            db.cmd(db.statement("update", "users", "set " + db.lineClause([
                {
                    key: "WALLET",
                    val: "WALLET-" + db.convFloat(bustedBets[i].BET_AMOUNT)
                },
                {
                    key: "WALLET_BLOCK",
                    val: "WALLET_BLOCK-" + db.convFloat(bustedBets[i].BET_AMOUNT)
                }
            ], ","), db.itemClause("ID", bustedBets[i].USERID)))
        }
    })
    // $this->db->update('crash_game_total', array('STATE' => 'BUSTED', 'BUSTEDTIME' => $this->curTime), array('ID' => $gameInfo->ID));

    // updated users table ---
    // $bustedBets = $this -> db -> from('crash_game_log') -> where('IS_BOT', '0') -> where('GAMENO', $gameInfo -> GAMENO) -> where('CASHOUTRATE', 0) -> get() -> result();
    // $this -> db -> set('PROFIT', '-BET_AMOUNT', false) -> where('GAMENO', $gameInfo -> GAMENO) -> where('CASHOUTRATE', 0) -> update('crash_game_log');
    // calc profit --> from crash_game_log
    // $profit = $this -> db -> from('crash_game_log') -> where('IS_BOT', '0') -> where('GAMENO', $gameInfo -> GAMENO)
    //     -> select_sum('PROFIT') -> get() -> row() -> PROFIT;
    // $this -> db -> update('crash_game_total', array('PROFIT' => -$profit), array('GAMENO' => $gameInfo -> GAMENO));

    // foreach($bustedBets as $busted) {
    //     $this -> db -> where("ID", $busted -> USERID)
    //         -> set('WALLET', 'WALLET - '.$busted -> BET_AMOUNT, false)
    //         -> set('WALLET_BLOCK', 'WALLET_BLOCK - '.$busted -> BET_AMOUNT, false)
    //         -> update('users');
    // }
}

var start_game = function (gameInfo, bust) {
    db.cmd(db.statement("update", "crash_game_total", "set " + db.lineClause([
        {
            key: "STATE",
            val: "STARTED"
        },
        {
            key: "BUST",
            val: db.convFloat(bust)
        },
        {
            key: "STARTTIME",
            val: dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss") // Date.now()
        }
    ], ","), db.itemClause("ID", gameInfo.ID)))
    return next_game()
    // $this -> db -> update(
    //     'crash_game_total',
    //     array('STATE' => 'STARTED', 'BUST' => $bust, 'STARTTIME' => date('Y-m-d H:i:s')),
    //     array('ID' => $gameInfo -> ID)
    // );
    // // returns next game no
    // return $this -> next_game();
}

var next_game = function () {
    var maxGameNo = 1
    return db.list(db.statement("select max(GAMENO) as GAMENO from", "crash_game_total", '', ''), true).then((maxGameNos) => {
        if (maxGameNos.length > 0) {
            maxGameNo = db.convInt(maxGameNos[0].GAMENO) == 0 ? 1 : (db.convInt(maxGameNos[0].GAMENO) + 1)
        }
        db.cmd(db.statement("insert into", "crash_game_total", "(GAMENO, REGTIME)", '',
            'VALUES (' + maxGameNo + ',' + "'" + dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss") + "'" + ')'))
        return maxGameNo
    })
    // $maxGameNo = $this -> db -> select('max(GAMENO) GAMENO') -> from('crash_game_total') -> get() -> row();
    // if ($maxGameNo) $maxGameNo = $maxGameNo -> GAMENO + 1;
    // else $maxGameNo = 1;

    // $this -> db -> insert('crash_game_total', array('GAMENO' => $maxGameNo, 'REGTIME' => date('Y-m-d H:i:s')));

    // return $maxGameNo;
}

var make_bet = function (gameNo, userID, betAmount) {
    var retData = null
    return userModel.bet_available(userID, betAmount).then((userCheckResult) => {
        if (userCheckResult != 'success') {
            retData = userCheckResult
            return retData
        }
        return db.list(db.statement("select * from", "crash_game_total", '', db.itemClause("GAMENO", gameNo)), true)
    }).then((rows) => {
        if (retData != null) {
            return retData
        }
        var gameExist = rows.length > 0
        if (!gameExist) {
            return 'Invalid game no'
        }

        db.cmd(db.statement("insert into", "crash_game_log",
            "(CREATE_TIME, GAMENO, USERID, IS_BOT, BET_AMOUNT)", '',
            'VALUES(' + "'" + dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss") + "'" + ',' + gameNo + ',' + userId + ',' + 0 + ',' + betAmount + ')'), true)
        userModel.new_bet(userID, betAmount)
        return 'success'
    })

    // $userCheckResult = $this -> user_model -> bet_available($userID, $betAmount);
    // if ($userCheckResult != 'success') return $userCheckResult;

    // $gameExist = $this -> db -> from('crash_game_total') -> where("GAMENO", $gameNo) -> get() -> row();
    // if (!$gameExist) {
    //     return 'Invalid game no';
    // }

    // // make crash game log
    // $this -> db -> insert(
    //     'crash_game_log',
    //     array(
    //         'CREATE_TIME' => $this -> curTime,
    //         'GAMENO' => $gameNo,
    //         'USERID' => $userID,
    //         'IS_BOT' => '0',
    //         'BET_AMOUNT' => $betAmount
    //     )
    // );
    // // then update user wallet
    // $this -> user_model -> new_bet($userId, $betAmount);
    // return 'success';
}

var bet = function (userID, betAmount, gameNo, isBot) {
    var userInfo = []
    var retData = null
    return db.list(db.statement("select * from", "crash_game_total", '', db.itemClause("GAMENO", gameNo)), true).then((rows) => {
        var gameExist = rows.length > 0
        if (!gameExist) {
            retData = {
                status: false,
                error: 'Invalid game no',
                data: null
            }
            return retData
        }
        return db.list(db.statement("select * from", "users", "", db.itemClause('ID', userID)), true)
    }).then((_userInfo) => {
        if (retData != null) {
            return retData
        }
        userInfo = _userInfo
        if (isBot) {
        } else {
            if (userInfo == null || userInfo.length <= 0) {
                retData = {
                    status: false,
                    error: 'Invalid User ID',
                    data: null
                }
                return retData
            }
            if (userInfo[0].WALLET_AVAILABLE < betAmount) {
                retData = {
                    status: false,
                    error: 'Wallet is not enough.',
                    data: null
                }
                return retData
            }
            db.cmd(db.statement("update", "users", "set " + db.lineClause([
                {
                    key: "WALLET_AVAILABLE",
                    val: userInfo[0].WALLET_AVAILABLE - betAmount
                },
                {
                    key: "WALLET_BLOCK",
                    val: userInfo[0].WALLET_BLOCK + betAmount
                }
            ], ","), db.itemClause('ID', userID)), true)
        }
        var str = ''
        str += "VALUES (" + "'" + dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss") + "'" + "," + gameNo + "," + userID + "," + (isBot ? 1 : 0) + ",0" + "," + betAmount + ")"
        console.log("Log: " + str)
        db.cmd(db.statement("insert into", "crash_game_log",
            "(CREATE_TIME, GAMENO, USERID, IS_BOT, CASHOUTRATE, BET_AMOUNT)", '',
            str), true)

        if (isBot) {
            db.cmd(db.statement("update", "crash_game_total", "set " + db.itemClause('BOTS', 'BOTS + 1'), db.itemClause('GAMENO', gameNo)), true)
        } else {
            db.cmd(db.statement("update", "crash_game_total", "set " + db.itemClause('USERS', 'USERS + 1'), db.itemClause('GAMENO', gameNo)), true)
        }
        retData = {
            status: true,
            error: '',
            data: {}
        }
        return retData
    })

    // $userID = $this->input->post('user_id');
    // $betAmount = $this->input->post('bet');
    // $gameNo = $this->input->post('game_no');
    // $isBot = $this->input->post('is_bot');

    // $gameExist = $this->db->from('crash_game_total')->where("GAMENO", $gameNo)->get()->row();
    // if ( !$gameExist ) {
    //     $this->load_json( array('status' => false, 'error' => 'Invalid game no') );
    // }

    // if ($isBot) {
    //     // do nothing ... ?
    // } else {
    //     $isBot = '0';

    //     $userInfo = $this->db->from('users')->where('ID', $userID)->get()->row();
    //     if ( !$userInfo ) {
    //         $this->load_json( array('status' => false, 'error' => 'Invalid User ID') );
    //     }
    //     if ( $userInfo->WALLET_AVAILABLE < $betAmount) {
    //         $this->load_json( array('status' => false, 'error' => 'Wallet is not enough.') );
    //     }

    //     $this->db->set('WALLET_AVAILABLE', $userInfo->WALLET_AVAILABLE - $betAmount)
    //         ->set('WALLET_BLOCK', $userInfo->WALLET_BLOCK + $betAmount)
    //         ->where('ID', $userID)
    //         ->update('users');
    // }

    // $betInfo = array(
    //     'CREATE_TIME' => $this->curTime,
    //     'GAMENO' => $gameNo,
    //     'USERID' => $userID,
    //     'IS_BOT' => $isBot,
    //     'CASHOUTRATE' => 0,
    //     'BET_AMOUNT' => $betAmount
    // );

    // $this->db->insert(
    //     'crash_game_log',
    //     $betInfo
    // );

    // // update game table
    // if ($isBot == '0') {
    //     $this->db->set('USERS', 'USERS +1', false)->where('GAMENO', $gameNo)->update('crash_game_total');
    // } else {
    //     $this->db->set('BOTS', 'BOTS +1', false)->where('GAMENO', $gameNo)->update('crash_game_total');
    // }

    // $this->load_json( array('status' => true) );
}

var cashout = function (userID, gameNo, cashRate, isBot) {
    var gameInfo = []
    var userInfo = []
    var betInfo = []
    var retData = null
    return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('GAMENO', gameNo)), true).then((_gameInfo) => {
        gameInfo = _gameInfo
        if (gameInfo == null || gameInfo.length <= 0 || gameInfo[0].STATE != 'STARTED') {
            retData = {
                status: false,
                error: 'Invalid game no or state',
                data: null
            }
            return retData
        }
        if (gameInfo[0].BUST < cashRate) {
            retData = {
                status: false,
                error: 'Cash rate is bigger than bust',
                data: null
            }
            return retData
        }
        if (isBot == false) {
            return db.list(db.statement("select * from", "users", "", db.itemClause('ID', userID)), true)
        } else {
            return db.list(db.statement("select * from", "crash_game_log", "", db.lineClause([
                {
                    key: 'USERID',
                    val: userID
                },
                {
                    key: 'GAMENO',
                    val: gameNo
                }
            ], "and")), true)
        }
    }).then((_rows) => {
        if (retData != null) {
            return retData
        }
        if (isBot == false) {
            userInfo = _rows
        } else {
            betInfo = _rows
        }
        if (isBot == false && (userInfo == null || userInfo.length <= 0)) {
            retData = {
                status: false,
                error: 'Invalid user id',
                data: null
            }
            return retData
        }
        if (betInfo == null || betInfo.length <= 0) {
            retData = {
                status: false,
                error: 'No bets',
                data: null
            }
            return retData
        }
        if (betInfo[0].CASHOUTRATE > 0) {
            retData = {
                status: false,
                error: 'Already cash out',
                data: null
            }
            return retData
        }
        console.log("cashRate: " + cashRate)
        var cashout = db.convFloat(betInfo[0].BET_AMOUNT) * cashRate
        console.log("BET_AMOUNT: " + betInfo[0].BET_AMOUNT)
        console.log("cashOut: " + cashout)
        db.cmd(db.statement("update", "crash_game_log", "set " + db.lineClause([
            {
                key: 'CASHOUTRATE',
                val: cashRate
            },
            {
                key: 'CASHOUT',
                val: cashout
            },
            {
                key: 'PROFIT',
                val: cashout - betInfo[0].BET_AMOUNT
            }
        ], ","), db.itemClause('ID', betInfo[0].ID)))
        if (isBot == false) {
            db.cmd(db.statement("update", "users", "set " + db.lineClause([
                {
                    key: 'WALLET',
                    val: cashout + db.convFloat(userInfo[0].WALLET) - db.convFloat(betInfo[0].BET_AMOUNT)
                },
                {
                    key: 'WALLET_AVAILABLE',
                    val: cashout + db.convFloat(userInfo[0].WALLET_AVAILABLE)
                },
                {
                    key: 'WALLET_BLOCK',
                    val: db.convFloat(userInfo[0].WALLET_BLOCK) - db.convFloat(betInfo[0].BET_AMOUNT)
                }
            ], ","), db.itemClause('ID', userID)))
        }

        retData = {
            status: true,
            error: '',
            data: {}
        }
        return retData
    })

    // $userID = $this->input->post('user_id');
    // $gameNo = $this->input->post('game_no');
    // $cashRate = $this->input->post('cash_rate') / 100;
    // $isBot = $this->input->post('is_bot');

    // $gameInfo = $this->db->from('crash_game_total')->where('GAMENO', $gameNo)->get()->row();
    // if (!$gameInfo || $gameInfo->STATE != 'STARTED') {
    //     $this->load_json(array(
    //         'status' => false,
    //         'error' => 'Invalid game id or status'
    //     ));
    // }
    // if ($gameInfo->BUST < $cashRate) {
    //     $this->load_json(array('status' => false, 'error' => 'Cash rate is bigger than bust'));
    // }

    // if ($isBot) {
    //     $this->db->where('IS_BOT', '1'); // when get bet log from db; is_bot is '1'
    // } else {
    //     $userInfo = $this->db->from('users')->where('ID', $userID)->get()->row();
    //     if (!$userInfo) {
    //         $this->load_json( array(
    //             'status' => false,
    //             'error' => 'Invalid user id'
    //         ));
    //     }

    //     $this->db->where('IS_BOT', '0');
    // }

    // $betInfo = $this->db->from('crash_game_log')->where('USERID', $userID)->where('GAMENO', $gameNo)->get()->row();
    // if (!$betInfo) {
    //     $this->load_json( array('status' => false, 'error' => 'No bets', 'query' => $this->db->last_query()));
    // }
    // if ($betInfo->CASHOUTRATE > 0) {
    //     $this->load_json( array('status' => false, 'error' => 'Already cash out'));
    // }

    // $cashout = $betInfo->BET_AMOUNT * $cashRate;
    // $this->db->where('ID', $betInfo->ID)
    //         ->set('CASHOUTRATE', $cashRate)
    //         ->set('CASHOUT', $cashout)
    //         ->set('PROFIT', $cashout - $betInfo->BET_AMOUNT)
    //         ->update('crash_game_log');

    // if (!$isBot) {
    //     $this->db->update(
    //         'users',
    //         array(
    //             'WALLET' => $cashout + $userInfo->WALLET - $betInfo->BET_AMOUNT,
    //             'WALLET_AVAILABLE' => $cashout + $userInfo->WALLET_AVAILABLE,
    //             'WALLET_BLOCK' => $userInfo->WALLET_BLOCK - $betInfo->BET_AMOUNT
    //         ),
    //         array('ID' => $userID)
    //     );
    // }

    // $this->load_json(array('status' => true));
}
var game_start = function (gameNo, gameBust) {
    var retData = null
    return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('GAMENO', gameNo)), true).then((gameInfo) => {
        if (gameInfo == null || gameInfo.length <= 0 || gameInfo[0].STATE != 'WAITING') {
            retData = {
                status: false,
                error: 'Invalid game no or state',
                data: null
            }
            return retData
        }
        return start_game(gameInfo[0], gameBust)
    }).then((nextGameNo) => {
        if (retData != null) {
            return retData
        } else {
            return {
                status: true,
                error: '',
                data: {
                    next_game_no: nextGameNo
                },
                next_game_no: nextGameNo
            }
        }
    })

    // $gameNo = $this->input->post('game_no');
    // $gameBust = $this->input->post('bust');

    // $gameInfo = $this->db->from('crash_game_total')->where('GAMENO', $gameNo)->get()->row();
    // if (!$gameInfo || $gameInfo->STATE != 'WAITING') {
    //     $this->load_json(array('status' => false, 'error' => 'Invalid game no or state'));
    // }

    // $nextGameNo = $this->CRASH->start_game($gameInfo, $gameBust);

    // $this->load_json(
    //     array(
    //         'status' => true,
    //         'next_game_no' => $nextGameNo
    //     )
    // );
}
var game_bust = function (gameNo) {
    var gameInfo = []

    return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('GAMENO', gameNo)), true).then((_gameInfo) => {
        gameInfo = _gameInfo
        if (gameInfo == null || gameInfo.length <= 0 || gameInfo[0].STATE != 'STARTED') {
            return {
                status: false,
                error: 'Invalid game no or state',
                data: null
            }
        }
        bust_game(gameInfo[0])
        return {
            status: true,
            error: '',
            data: {}
        }
    })

    // $gameNo = $this->input->post('game_no');
    // // $gameBust = $this->input->post('bust') / 100;

    // $gameInfo = $this->db->from('crash_game_total')->where('GAMENO', $gameNo)->get()->row();
    // if (!$gameInfo || $gameInfo->STATE != 'STARTED') {
    //     $this->load_json(array('status' => false, 'error' => 'Invalid game no or state'));
    // }

    // $this->CRASH->bust_game($gameInfo);

    // $this->load_json(array('status' => true));
}
var game_init = function () {
    var waitingGame = []
    var bots = []
    var game_player_list = []
    var startedGame = []
    var retData = null
    return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('STATE', 'WAITING')), true).then((_waitingGame) => {
        waitingGame = _waitingGame
        return db.list(db.statement("select * from", "crash_game_bot", "", db.itemClause('ENABLE', '1')), true)
    }).then((_bots) => {
        bots = _bots
        if (waitingGame !== undefined && waitingGame != null && waitingGame.length > 0) {
            return db.list(db.statement("select * from", "crash_game_log", "", db.itemClause('GAMENO', waitingGame[0].GAMENO)), true)
        } else {
            return []
        }
    }).then((_game_player_list) => {
        game_player_list = _game_player_list
        return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('STATE', 'STARTED')), true)
    }).then((_startedGame) => {
        startedGame = _startedGame
        if (waitingGame != null && waitingGame.length > 0) {
            retData = {
                status: true,
                error: '',
                data: {
                    game_no: waitingGame[0].GAMENO,
                    game_player_list: game_player_list,
                    bots: bots
                },
                game_no: waitingGame[0].GAMENO,
                game_player_list: game_player_list,
                bots: bots
            }
            return retData
        }
        if (startedGame != null && startedGame.length > 0) {
            bust_game(startedGame)
        }
        return next_game()
    }).then((next_game_no) => {
        if (retData != null) {
            return retData
        }
        retData = {
            status: true,
            error: '',
            data: {
                game_no: next_game_no,//waitingGame[0].GAMENO,
                bots: bots
            },
            game_no: next_game_no,
            bots: bots
        }
        return retData
    })

    // // cur game is waiting game
    // // if there's an waiting game, we don't need to create new...
    // $waitingGame = $this->db->from('crash_game_total')->where('STATE', 'WAITING')->get()->row();
    // $bots = $this->db->from('crash_game_bot')->where('ENABLE', '1')->get()->result();
    // if ($waitingGame) {
    //     $this->load_json(
    //         array(
    //             'status' => true,
    //             'game_no' => $waitingGame->GAMENO,
    //             // this game's player list
    //             'game_player_list' => $this->db->from('crash_game_log')->where('GAMENO', $waitingGame->GAMENO)->get()->result(),
    //             'bots' => $bots
    //         )
    //     );
    // }

    // // if game is started, then finishes it
    // $startedGame = $this->db->from('crash_game_total')->where('STATE', 'STARTED')->get()->row();
    // if ($startedGame) {
    //     $this->CRASH->bust_game($startedGame);
    // }

    // $this->load_json(
    //     array(
    //         'status' => true,
    //         'game_no' => $this->CRASH->next_game(),
    //         'bots' => $bots
    //     )
    // );
}
var get_profit_rate = function () {
    return db.list(db.statement("select 'FROM', 'TO', 'PERCENT' from", "crash_game_profit", "", ""), true).then((profit_rate) => {
        return {
            status: true,
            error: '',
            data: {
                profit_rate: profit_rate[0]
            },
            profit_rate: profit_rate[0]
        }
    })
}
var game_finish_start = function (gameNo, gameBust) {
    var retData = null
    var gameInfo = []
    return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('GAMENO', gameNo)), true).then((_gameInfo) => {
        if (_gameInfo == null || _gameInfo.length <= 0 || _gameInfo[0].STATE != 'WAITING') {
            retData = {
                status: false,
                error: 'Invalid game no or state',
                data: null
            }
            return retData
        }
        gameInfo = _gameInfo
        return start_game(gameInfo[0], gameBust)
    }).then((nextGameNo) => {
        if (retData != null) {
            return retData
        }
        bust_game(gameInfo[0])
        return {
            status: true,
            error: '',
            data: {
                next_game_no: nextGameNo
            },
            next_game_no: nextGameNo
        }
    })

    // $gameNo = $this->input->post('game_no');
    // $gameBust = $this->input->post('bust');

    // $gameInfo = $this->db->from('crash_game_total')->where('GAMENO', $gameNo)->get()->row();
    // if (!$gameInfo || $gameInfo->STATE != 'WAITING') {
    //     $this->load_json(array('status' => false, 'error' => 'Invalid game no or state'));
    // }

    // $nextGameNo = $this->CRASH->start_game($gameInfo, $gameBust);
    // $this->CRASH->bust_game($gameInfo);

    // $this->load_json(array('status' => true, 'next_game_no' => $nextGameNo));
}
var game_log = function (limit) {
    return db.list(db.statement("select * from", "crash_game_total", "", db.itemClause('STATE', 'BUSTED'), 'ORDER BY ID DESC LIMIT 0, ' + limit), true).then((gameInfo) => {
        return gameInfo
    })
}
var getHistory = function(id, start_date, end_date, page, limit) {
    var whereItems = []
    if (id !== undefined && isNaN(parseInt(id)) == false && parseInt(id) >= 0) {
        whereItems.push({
            key: "ID",
            val: parseInt(id)
        })
    } else {
        if (start_date !== undefined && start_date != null && start_date !== '') {
            if (end_date !== undefined && end_date != null && end_date !== '') {
                whereItems.push({
                    key: "REGTIME",
                    val: start_date + " 00:00:00",
                    opt: ">="
                })
                whereItems.push({
                    key: "REGTIME",
                    val: end_date + " 23:59:59",
                    opt: "<="
                })
            }
        }
    }
    var total = 0
    return db.list(db.statement("select count(*) as total from", "crash_game_total", '', whereItems.length > 0 ? db.lineClause(whereItems, 'and') : '', ''), true).then((rows) => {
        total = rows[0].total
        return db.list(db.statement("select * from", "crash_game_total", "", whereItems.length > 0 ? db.lineClause(whereItems, 'and') : '', 'ORDER BY ID ASC LIMIT ' + (page - 1) * limit + ',' + (page * limit)), true)
    }).then((rows) => {
        return {
            total: total,
            items: rows
        }
    })
}
var getGameLog = function (id) {
    var cmd = "SELECT crash_game_log.ID, crash_game_log.CREATE_TIME, crash_game_log.BET_AMOUNT, crash_game_log.UPDATE_TIME, crash_game_log.GAMENO,\
    crash_game_log.USERID, crash_game_log.IS_BOT, crash_game_log.BET, crash_game_log.CASHOUTRATE, crash_game_log.CASHOUT, crash_game_log.PROFIT,\
    crash_game_bot.F_ID AS BOT_NAME, users.USERNAME AS USER_NAME, users.AVATAR_SMALL AS USER_AVATAR FROM"
    var extra = "LEFT JOIN crash_game_bot ON crash_game_bot.ID = crash_game_log.USERID LEFT JOIN users ON users.ID = crash_game_log.USERID"

    var statement = cmd + " crash_game_log " + extra + " where crash_game_log.GAMENO=" + id
    return db.list(statement, true).then((gameInfo) => {
        return gameInfo
    })
}
var crashModel = {
    bust_game: bust_game,
    start_game: start_game,
    next_game: next_game,
    // make_bet: make_bet,
    bet: bet,
    cashout: cashout,
    game_start: game_start,
    game_bust: game_bust,
    game_init: game_init,
    get_profit_rate: get_profit_rate,
    game_finish_start: game_finish_start,
    game_log: game_log,
    getHistory: getHistory,
    getGameLog: getGameLog
}

module.exports = crashModel