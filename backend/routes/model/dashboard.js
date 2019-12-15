var db = require('./../../utils/database');
var rn = require('random-number');
var dateFormat = require('dateformat');

var getStatistics = function (type) {
    if (type === 'user') {
        return [
            { desc: 'New users', value: '0' },
            { desc: 'Logged users', value: '10' },
            { desc: 'Active users', value: '10' }
        ]
    } else if (type === 'betting') {
        return [
            { desc: 'Ticket placed', value: '0' },
            { desc: 'Lost tickets', value: '0' },
            { desc: 'Won tickets', value: '0' },
            { desc: 'Pending tickets', value: '0' },
            { desc: 'Cancelled tickets', value: '0' }
        ]
    } else if (type === 'financial') {
        return [
            { desc: 'Total deposits', value: '0' },
            { desc: 'Pending deposits', value: '0' },
            { desc: 'Average deposits', value: '0' },
            { desc: 'Highest deposits', value: '0' },
            { desc: 'Total withdrawals', value: '0' },
            { desc: 'Pending withdrawals', value: '0' },
            { desc: 'Average withdrawals', value: '0' },
            { desc: 'Highest withdrawals', value: '0' }
        ]
    } else {
        return []
    }
}
var getVisits = function (type) {
    var options = {
        min: 0
        , max: 100
        , integer: true
    }
    var tempArr = []
    var tempArr1 = []
    for (var i = 0; i < 30; i++) {
        tempArr.push(rn(options))
        tempArr1.push(rn(options))
    }
    if (type === 'user') {
        return {
            unique_visits: tempArr,
            page_views: tempArr1
        }
    } else if (type === 'betting') {
        return {
            unique_visits: tempArr,
            page_views: tempArr1
        }
    } else if (type === 'financial') {
        return {
            unique_visits: tempArr,
            page_views: tempArr1
        }
    } else {
        return {
            unique_visits: [],
            page_views: []
        }
    }
}
var model = {
    getStatistics: getStatistics,
    getVisits: getVisits
}

module.exports = model;