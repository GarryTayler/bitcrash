var path = require('path');

var config = {
    debug: true,
    crash_port: 4202,
    chat_port : 4204,
	mysql : {
		host : 'localhost',
		user : 'root',
        password : '',
		database : 'bitcrash'
    },
    main_host_url : "http://localhost:3001/api/"
}

module.exports = config