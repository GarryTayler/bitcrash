var express = require('express');
var router = express.Router();

var model = require('./model/dashboard');
router.post('/statistics', async function (req, res) {
    const { type } = req.body

    console.log(type)
    var rows = model.getStatistics(type)
    return res.json({
        code: 20000,
        data: {
            values: rows
        }
    })
});
router.post('/visits', async function (req, res) {
    const { type } = req.body

    console.log(type)
    var data = model.getVisits(type)
    return res.json({
        code: 20000,
        data: data
    })
});
module.exports = router;
