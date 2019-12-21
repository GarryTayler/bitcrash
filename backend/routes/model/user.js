var md5 = require('md5');
var db = require('./../../utils/database');
var rn = require('random-number');
var dateFormat = require('dateformat');
var config = require('../../src/config');
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
    var pwdStr = '';
    /*if (query.password != undefined) {
        var md5stream = new MD5()
        md5stream.end(query.password)
        pwdStr = md5stream.read().toString('hex')
    }*/
    if (query.password != undefined) {
        pwdStr = md5(query.password);
    }
    var sql = "select * from users"
    var whereClause = ''
    var query_cnt = 0
    if (query.search_key != undefined) {
        whereClause += "(username='" + query.search_key + "'" + " or " + "email='" + query.search_key + "')"
        query_cnt++
    } else {
        if (query.username != undefined) {
            whereClause += (query_cnt != 0 ? "and " : " ") + "username='" + query.username + "'"
            query_cnt++
        }
        if (query.email != undefined) {
            whereClause += (query_cnt != 0 ? "and " : " ") + "email='" + query.email + "'"
            query_cnt++
        }
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
var generateRandomString = function (length = 25) {
    characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    charactersLength = characters.length;
    randomString = '';

    var options = {
        min: 0
        , max: charactersLength - 1
        , integer: true
    }

    for (var i = 0; i < length; i++) {
        randomString += characters[rn(options)];
    }
    return randomString;
}
var signup = function (data) {
    return new Promise((resolve, reject) => {
        if (data.username == undefined || data.username == null || data.username == '') {
            resolve({
                code: false
            })
            return
        }
        if (data.email == undefined || data.email == null || data.email == '') {
            resolve({
                code: false
            })
            return
        }
        if (data.password == undefined || data.password == null || data.password == '') {
            resolve({
                code: false
            })
            return
        }
        var token = generateRandomString()
        var pwdStr = "";
        pwdStr = md5(data.password);
        var values = "(" + "'" + dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss") + "'" + ", "
        values += "'" + data.username + "', "
        values += "'" + pwdStr + "', "
        values += "'" + data.email + "', "
        values += "'" + config.general_profile_url + "',"
        values += "'" + token + "'" + ")"
        var statement = db.statement("insert into", "users", "(CREATE_TIME, USERNAME, PASSWORD, EMAIL, AVATAR, API_TOKEN)", "", "VALUES " + values)
        db.con.query(statement, function (err, results, fields) {
            if (err) {
                reject(err)
                throw err
            }
            resolve({
                code: true,
                insert_id: results.insertId,
                token: token
            })
        });
    })
}
var getList = function (search_key, page, limit) {
    var total = 0
    var whereItems = []

    if (search_key !== undefined && search_key != '') {
        whereItems.push(
            {
                key: 'username',
                val: '%' + search_key + '%',
                opt: 'like'
            }
        )

        whereItems.push(
            {
                key: 'email',
                val: '%' + search_key + '%',
                opt: 'like'
            }
        )
    }
    var whereClause = (whereItems.length > 0 ? "(" + db.lineClause(whereItems, "or") + ")" + " and " : '') + db.itemClause('DEL_YN', 'N')

    return db.list(db.statement("select count(*) as total from", "users", "", whereClause), true).then((rows) => {
        total = rows[0].total
        return db.list(db.statement("select * from", "users", "", whereClause, 'LIMIT ' + (page - 1) * limit + ',' + (page * limit)), true)
    }).then((rows) => {
        return {
            total: total,
            items: rows
        }
    })
}
var update = function (params) {
    const {id, del_yn, state} = params
    if (id === undefined || id == 0) {
        return false
    } else {
        var whereClause = db.itemClause('ID', parseInt(id))
        var setItems = []
        if (del_yn !== undefined && del_yn != '') {
            setItems.push({
                key: 'DEL_YN',
                val: del_yn
            })
        }
        if (state !== undefined) {
            setItems.push({
                key: 'state',
                val: parseInt(state)
            })
        }
        db.cmd(db.statement("update", "users", "set " + db.lineClause(setItems, ","), whereClause))
        return true
    }
}
var userModel = {
    getUserInfo: getUserInfo,
    signup: signup,

    bet_available: bet_available,
    new_bet: new_bet,
    lose_game: lose_game,
    win_game: win_game,

    getList: getList,
    update: update
}

module.exports = userModel;