var db = require('./../../utils/database');
var rn = require('random-number');
var dateFormat = require('dateformat');

var getList = function (search_key, type, page, limit) {
    var total = 0
    var whereClause = search_key === undefined || search_key == '' ? '' : db.lineClause([
        {
            key: 'answer',
            val: '%' + search_key + '%',
            opt: 'like'
        },
        {
            key: 'question',
            val: '%' + search_key + '%',
            opt: 'like'
        }
    ], 'or')
    var typeClause = type == -1 ? "" : " And type=" + type
    whereClause = whereClause == '' ? "deleted=0" + typeClause : "(" + whereClause + ") AND deleted=0" + typeClause
    return db.list(db.statement("select count(*) as total from", "faq", "", whereClause), true).then((rows) => {
        total = rows[0].total
        return db.list(db.statement("select * from", "faq", "", whereClause, 'LIMIT ' + (page - 1) * limit + ',' + (page * limit)), true)
    }).then((rows) => {
        return {
            total: total,
            items: rows
        }
    })
}
var add = function (params) {
    const {type, question, answer} = params
    var setItems = []
    var insertValues = "("
    var insertFields = "("
    if (answer !== undefined) {
        setItems.push({
            key: 'answer',
            val: answer
        })
        insertValues += "'" + answer + "'" + ","
        insertFields += "answer,"
    }

    if (question !== undefined) {
        setItems.push({
            key: 'question',
            val: question
        })
        insertValues += "'" + question + "'" + ","
        insertFields += "question,"
    }

    if (type !== undefined) {
        setItems.push({
            key: 'type',
            val: type
        })
        insertValues += type + ","
        insertFields += "type,"
    }

    insertFields += "create_time,"
    insertValues += "'" + dateFormat(new Date(), "yyyy-mm-dd hh:MM:ss") + "'" + ","

    insertFields = insertFields.substr(0, insertFields.length - 1)
    insertValues = insertValues.substr(0, insertValues.length - 1)
    insertFields += ")"
    insertValues += ")"
    db.cmd(db.statement("insert into", "faq", insertFields, '', 'VALUES ' + insertValues))
    return true
}
var model = {
    getList: getList,
    add: add
}

module.exports = model;