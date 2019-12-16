var express = require('express');
var router = express.Router();

var model = require('./model/faq');
router.post('/list', async function (req, res) {
    const { search_key, type, page, limit } = req.body

    console.log(search_key)
    var i_page = isNaN(parseInt(page)) ? 1 : parseInt(page)
    var i_limit = isNaN(parseInt(limit)) ? 1 : parseInt(limit)
    var i_type = type === undefined ? -1 : (isNaN(parseInt(type)) ? -1 : parseInt(type))
    var data = await model.getList(search_key, i_type, i_page, i_limit)
    return res.json({
        code: 20000,
        data: data
    })
});
router.post('/add', function (req, res) {
    var ret = model.add(req.body)
    return res.json({
        code: ret ? 20000 : 60000,
        message: ret ? '' : 'Adding failed.',
        data: null
    })
});
module.exports = router;
