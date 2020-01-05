var db = require('./../../utils/database');

exports.insertTxn = function (insertData, callback) {
    var timestamp = Math.floor(Date.now() / 1000);
    var amount_coins = parseInt(Math.pow(10 , 6) * insertData.amount);
    var insertQuery =
    "INSERT INTO deposit_withdraw_log ( " +
    " `USER_ID`, " +
    "`TYPE`, " +
    "`AMOUNT_BTC`, " +
    "`AMOUNT_COINS`, " +
    "`FEE`, " +
    "`DETAIL`, " +
    "`TXHASH`, " +
    "`STATUS`, " +
    "`CREATE_TIME`, " +
    "`UPDATE_TIME`) " +
    "VALUES ('" +
    insertData.who + "', '" +
    insertData.type + "', '" +
    insertData.amount + "', '" +
    amount_coins + "', '" +
    insertData.fees + "', '" +
    insertData.detail + "', '" +
    insertData.txhash + "', 0 , " +
    timestamp + ", " +
    timestamp + ")";

    db.con.query(insertQuery, function (err, rows, fields) {
        if (err) {
            return callback(err, null);
        }
        var return_data = {
            res: true,
            content: rows
        }
        return callback(null, return_data);
    });
}