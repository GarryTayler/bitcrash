var express = require('express');
var router = express.Router();
var dateFormat = require('dateformat');
var crashModel = require('./model/crash');

var db = require('./../utils/database');
 router.post('/bet', async function (req, res) {
    const { user_id, bet, game_no, is_bot } = req.body
    var ret = await crashModel.bet(user_id, bet, game_no, is_bot == undefined ? false : is_bot == 1)
    return res.json(ret)
})
router.post('/addbet', async function (req, res) {
    const { user_id, bet, game_no, is_bot } = req.body
    var ret = await crashModel.bet(user_id, bet, game_no, is_bot == undefined ? false : is_bot == 1)
    return res.json(ret)
})
router.post('/cashout', async function (req, res) {
    const { user_id, game_no, cash_rate, is_bot } = req.body
    var ret = await crashModel.cashout(user_id, game_no, cash_rate, is_bot == undefined ? false : is_bot == 1)
    return res.json(ret)
})
router.post('/game_start', async function (req, res) {
    const { game_no, bust } = req.body
    var ret = await crashModel.game_start(game_no, bust)
    return res.json(ret)
})
router.post('/game_bust', async function (req, res) {
    const { game_no } = req.body
    var ret = await crashModel.game_bust(game_no)
    return res.json(ret)
})
router.post('/init', async function (req, res) {
    var ret = await crashModel.game_init()
    return res.json(ret)
})
router.post('/game_finish_start', async function (req, res) {
    const { game_no, bust } = req.body
    var ret = await crashModel.game_finish_start(game_no, bust)
    return res.json(ret)
})
router.post('/game_log', async function (req, res) {
    const { limit } = req.body
    var ret = await crashModel.game_log(limit)
    return res.json({
        code: 20000,
        data: ret
    });
})
router.post('/history', async function (req, res) {
    const { id, start_date, end_date, page, limit } = req.body
    var i_page = isNaN(parseInt(page)) ? 1 : parseInt(page)
    var i_limit = isNaN(parseInt(limit)) ? 1 : parseInt(limit)
    var ret = await crashModel.getHistory(id, start_date, end_date, i_page, i_limit)
    return res.json({
        code: 20000,
        data: ret
    });
})
router.post('/log', async function (req, res) {
    const { id } = req.body
    if (id == undefined || isNaN(parseInt(id))) {
        return res.json({
            code: 60000,
            message: 'ID param is not defined.',
            data: null
        });
    }
    var i_id = parseInt(id)
    var ret = await crashModel.getGameLog(i_id)
    return res.json({
        code: 20000,
        data: {
          items: ret
        }
    });
})
module.exports = router;
