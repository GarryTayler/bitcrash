var express = require('express');
var router = express.Router();
var dateFormat = require('dateformat');

var MD5 = require('md5.js');
var crashModel = require('./model/crash');

var db = require('./../utils/database');

router.post('/emit', async function (req, res) {

    const { user_id, bet, game_no, is_bot } = req.body
    var ret = await crashModel.bet(user_id, bet, game_no, is_bot, dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss"))
    return res.json(ret)
})