var MD5 = require('md5');
var db = require('./../../utils/database');

var bet_available = function (userID, betAmount) {
    return db.list(db.statement("select * from", "users", '', db.itemClause('ID', userID)), true).then((userInfo) => {
        if (userInfo == null || userInfo.length <= 0) {
            return 'Invalid User ID'
        }
        if (db.convInt(userInfo[0].WALLET_AVAILABLE) < betAmount) {
            return 'Wallet is not enough.'
        }
        return 'success'
    })

    // $userInfo = $this->db->from('users')->where('ID', $userID)->get()->row();
    // if ( !$userInfo ) {
    //     return 'Invalid User ID';
    // }
    // if ( $userInfo->WALLET_AVAILABLE < $betAmount) {
    //     return 'Wallet is not enough.';
    // }
    // return 'success';
}
var new_bet = function (userID, betAmount) {
    db.cmd(db.statement("update", "users", "set " + db.lineClause([
        {
            key: "WALLET_BLOCK",
            val: "WALLET_BLOCK + " + betAmount
        },
        {
            key: "WALLET_AVAILABLE",
            val: "WALLET_AVAILABLE - " + betAmount
        }
    ], ","), db.itemClause("ID", userID)))
    // $this->db->where('ID', $userID)
    //     ->set('WALLET_BLOCK', 'WALLET_BLOCK + '.$betAmount, false)
    //     ->set('WALLET_AVAILABLE', 'WALLET_AVAILABLE - '.$betAmount, false)
    //     ->update('users');
}

var lose_game = function (userID, betAmount) {
    db.cmd(db.statement("update", "users", "set " + db.lineClause([
        {
            key: "WALLET_BLOCK",
            val: "WALLET_BLOCK - " + betAmount
        },
        {
            key: "WALLET",
            val: "WALLET - " + betAmount
        }
    ], ","), db.itemClause('ID', userID)))
    // // when user loses bet, block amount and wallet reduces
    // $this->db->where('ID', $userID)
    //     ->set('WALLET_BLOCK', 'WALLET_BLOCK - '.$betAmount, false)
    //     ->set('WALLET', 'WALLET - '.$betAmount, false)
    //     ->update('users');
}

var win_game = function (
    userID, 
    betAmount, // his bet amount
    totalProfit // that game's total bet --> his total profit
) {
    db.cmd(db.statement("update", "users", "set " + db.lineClause([
        {
            key: "WALLET",
            val: "WALLET + " + totalProfit
        },
        {
            key: "WALLET_AVAILABLE",
            val: "WALLET_AVAILABLE + " + (betAmount + totalProfit)
        },
        {
            key: "WALLET_BLOCK",
            val: "WALLET_BLOCK - " + betAmount
        }
    ], ","), db.itemClause('ID', userID)))
    // // when user wins game, he should get money from that game
    // $this->db->where('ID', $userID)
    //     ->set('WALLET', 'WALLET +' . $totalProfit, false)
    //     ->set('WALLET_AVAILABLE', 'WALLET_AVAILABLE + '.($betAmount + $totalProfit), false)
    //     ->set('WALLET_BLOCK', 'WALLET_BLOCK - '.$betAmount, false)
    //     ->update('users');
}
var getUserInfo = function (query, callback) {
    var pwdStr = ''
    if (query.password != undefined) {
        var md5stream = new MD5()
        md5stream.end(query.password)
        pwdStr = md5stream.read().toString('hex')
    }

    var sql = "select * from users"
    var whereClause = ''
    var query_cnt = 0
    if (query.username != undefined) {
        whereClause += (query_cnt != 0 ? "and " : " ") + "username='" + query.username + "'"
        query_cnt++
    }
    if (query.email != undefined) {
        whereClause += (query_cnt != 0 ? "and " : " ") + "email='" + query.email + "'"
        query_cnt++
    }
    if (query.password != undefined) {
        whereClause += (query_cnt != 0 ? " and " : " ") + "PASSWORD='" + pwdStr + "'"
        query_cnt++
    }
    if (query.token != undefined) {
        whereClause += (query_cnt != 0 ? " and " : " ") + "API_TOKEN='" + query.token + "'"
        query_cnt++
    }
    if (whereClause == '') {
        callback([])
        return;
    }
    sql = sql + (whereClause == '' ? '' : ' where ' + whereClause)
    console.log(sql)
    db.con.query(sql, function (err, rows, fields) {
        if (err) {
            if (callback != null) {
                callback([])
            }
            throw err
        }
        console.log(rows)
        callback(rows)
    });
}
var userModel = {
    getUserInfo: getUserInfo,
    bet_available: bet_available,
    new_bet: new_bet,
    lose_game: lose_game,
    win_game: win_game
}

module.exports = userModel;