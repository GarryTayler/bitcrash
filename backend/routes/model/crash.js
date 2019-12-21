
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
            val: Math.floor(Date.now() / 1000)
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
            val: Math.floor(Date.now() / 1000) 
        }
    ], ","), db.itemClause("ID", gameInfo.ID)))
    return next_game()
}

var next_game = function () {
    var maxGameNo = 1
    return db.list(db.statement("select max(GAMENO) as GAMENO from", "crash_game_total", '', ''), true).then((maxGameNos) => {
        if (maxGameNos.length > 0) {
            maxGameNo = db.convInt(maxGameNos[0].GAMENO) == 0 ? 1 : (db.convInt(maxGameNos[0].GAMENO) + 1)
        }
        db.cmd(db.statement("insert into", "crash_game_total", "(GAMENO, REGTIME, UPDATETIME)", '',
            'VALUES (' + maxGameNo + ',' + "'" + Math.floor(Date.now() / 1000) + "'"+ ',' + "'" + Math.floor(Date.now() / 1000) + "'" + ')'))
        return maxGameNo
    })
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
            "(CREATE_TIME, UPDATE_TIME , GAMENO, USERID, IS_BOT, BET_AMOUNT)", '',
            'VALUES(' + "'" + Math.floor(Date.now() / 1000) + "'" + ',' +
            "'" + Math.floor(Date.now() / 1000) + "'" + ',' +
            gameNo + ',' +
            userId + ',' +
            '0' + ',' +
            betAmount + ')'), true)
        userModel.new_bet(userID, betAmount)
        return 'success'
    })
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
        str += "VALUES (" + "'" + Math.floor(Date.now() / 1000) + "'" + "," + "'" + Math.floor(Date.now() / 1000) + "'" + "," + gameNo + "," + userID + "," + (isBot ? 1 : 0) + ",0" + "," + betAmount + ")"
        console.log("Log: " + str)
        db.cmd(db.statement("insert into", "crash_game_log",
            "(CREATE_TIME, UPDATE_TIME ,  GAMENO, USERID, IS_BOT, CASHOUTRATE, BET_AMOUNT)", '',
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
    crash_game_bot.F_ID AS BOT_NAME, users.USERNAME AS USER_NAME, users.AVATAR AS USER_AVATAR FROM"
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
    game_finish_start: game_finish_start,
    game_log: game_log,
    getHistory: getHistory,
    getGameLog: getGameLog
}

module.exports = crashModel