var express = require('express');
var router = express.Router();
var dateFormat = require('dateformat');

var MD5 = require('md5.js');
var crashModel = require('./model/crash');

var db = require('./../utils/database');
// function getRows(res) {
//     var promise = new Promise((resolve, reject) => {
//         var statement = db.statement("select * from", "crash_game_total", "", db.itemClause('STATE', 'WAITING'))
//         db.con.query(statement, function (err, rows, fields) {
//             if (err) {
//                 reject(err)
//             }
//             resolve(rows)
//         });
//     })
//     return promise
// }
// router.post('/temp', async function (req, res) {
//     var gameNo = req.body.game_no
//     console.log("Temp " + gameNo)
//     // var temp1 = await crashModel.temp()
//     // var temp2 =  getRows()
//     res.json({
//         msg: "temp1"
//         // msg1: temp2
//     })
// })
router.post('/bet', async function (req, res) {

    const { user_id, bet, game_no, is_bot } = req.body
    var ret = await crashModel.bet(user_id, bet, game_no, is_bot, dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"))
    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: ret
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error,
    //         data: ret
    //     })
    // }
})
router.post('/cashout', async function (req, res) {
    const { user_id, game_no, cash_rate, is_bot } = req.body
    console.log("cash_rate: " + cash_rate)
    var ret = await crashModel.cashout(user_id, game_no, cash_rate / 100, is_bot)
    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: {
    //         }
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error
    //     })
    // }
})
router.post('/game_start', async function (req, res) {

    const { game_no, bust } = req.body
    console.log("game_start " + game_no + " " + bust)
    var ret = await crashModel.game_start(game_no, bust)

    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: ret.data
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error
    //     })
    // }
})
router.post('/game_bust', async function (req, res) {

    const { game_no } = req.body
    var ret = await crashModel.game_bust(game_no, dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"))
    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: {
    //         }
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error
    //     })
    // }
})
router.post('/init', async function (req, res) {
    var ret = await crashModel.game_init(dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"))

    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: ret.data
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error
    //     })
    // }
})
router.post('/profit_rate', async function (req, res) {
    var ret = await crashModel.get_profit_rate()
    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: ret.data
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error
    //     })
    // }
})
router.post('/game_finish_start', async function (req, res) {
    const { game_no, bust } = req.body
    var ret = await crashModel.game_finish_start(game_no, bust, dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"))
    return res.json(ret)
    // if (ret.status) {
    //     return res.json({
    //         code: 20000,
    //         data: ret.data
    //     });
    // } else {
    //     return res.json({
    //         code: 60204,
    //         message: ret.error
    //     })
    // }
})

module.exports = router;
