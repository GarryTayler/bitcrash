var path = require('path');
var crash_port = 4202
var chat_port = 4204
var main_port = 3001
//var base_domain = "45.76.180.140"
var base_domain = "localhost"

var config = {
    debug: true,
    crash_port: crash_port,
    chat_port : chat_port,
    mysql : {
        host : 'localhost',
        user : 'root',
        //password : 'mirai2018',
        password : '',
        database : 'bitcrash'
    },
    base_domain: base_domain,
    main_host_url : "http://" + base_domain + ":" + main_port + "/api/",
    //general_profile_url : "http://" + base_domain + ":7801/img/uploads/avatar/general_profile.png"c
    general_profile_url : "http://" + base_domain + ":8080/img/uploads/avatar/general_profile.png"
}

module.exports = config