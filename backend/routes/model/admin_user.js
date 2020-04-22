/** @remove comments before production
 * var md5 = require('md5');
 */
var db = require('./../../utils/database');
var rn = require('random-number');
var dateFormat = require('dateformat');

var getUserInfo = function (query, callback) {
    var pwdStr = ''

    if(query.password != undefined) {
        // @remove comments before production
        // pwdStr = md5(query.password);
        pwdStr = '827ccb0eea8a706c4c34a16891f84e7b';
    }

    var sql = "select * from admin"
    var whereClause = ''
    var query_cnt = 0
    if (query.search_key != undefined) {
        whereClause += "(USERNAME='" + query.search_key + "'" + " or " + "EMAIL='" + query.search_key + "')"
        query_cnt++
    } else {
        if (query.username != undefined) {
            whereClause += (query_cnt != 0 ? "and " : " ") + "USERNAME='" + query.username + "'"
            query_cnt++
        }
        if (query.email != undefined) {
            whereClause += (query_cnt != 0 ? "and " : " ") + "EMAIL='" + query.email + "'"
            query_cnt++
        }
    }
    if (query.password != undefined) {
        whereClause += (query_cnt != 0 ? " and " : " ") + "PASSWORD='" + pwdStr + "'"
        query_cnt++
    }
    if (query.token != undefined) {
        whereClause += (query_cnt != 0 ? " and " : " ") + /*"API_TOKEN='"*/"ID='" + query.token + "'"
        query_cnt++
    }
    if (whereClause == '') {
        callback([])
        return;
    }
    sql = sql + (whereClause == '' ? '' : ' where ' + whereClause)
    db.con.query(sql, function (err, rows, fields) {
        if (err) {
            if (callback != null) {
                callback([])
            }
            throw err
        }
        callback(rows)
    });
}
var updateUserInfo = function (query, callback) {
    if (query.old_pwd == undefined || query.old_pwd == '') {
        callback(false)
        return
    }

    var oldPwdStr = ''
    var newPwdStr = ''

    if (query.old_pwd != undefined && query.old_pwd != '') {
        // @remove comments before production
        // oldPwdStr = md5(query.old_pwd);
        oldPwdStr = '827ccb0eea8a706c4c34a16891f84e7b';
    }
    if (query.new_pwd != undefined && query.new_pwd != '') {
        // @remove comments before production
        // newPwdStr = md5(query.new_pwd);
        newPwdStr = '827ccb0eea8a706c4c34a16891f84e7b';
    }

    var sql = "select * from admin where ID=1 and PASSWORD='" + oldPwdStr + "'"
    db.con.query(sql, function (err, rows, fields) {
        if (err) {
            if (callback != null) {
                callback(false)
            }
            throw err
        }
        if (rows.length > 0) {
            var update_sql = "update admin set "
            var setClause = "PASSWORD='" + newPwdStr + "'" + " "
            var whereClause = "ID=1" + " and " + "PASSWORD='" + oldPwdStr + "'" + " and " + "DEL_YN='N'"
            db.con.query(update_sql + setClause + whereClause);
            callback(true)
        } else {
            callback(false)
        }
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
var userModel = {
    getUserInfo: getUserInfo,
    updateUserInfo: updateUserInfo
}

module.exports = userModel;