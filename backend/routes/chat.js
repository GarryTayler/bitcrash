var express = require('express');
var router = express.Router();
var MD5 = require('md5.js');
var chatModel = require('./model/chat');
var config = require('./../src/config');
var dateFormat = require('dateformat');

var axios = require('axios')

var instance = axios.create({
    baseURL: 'http://localhost:' + config.chat_port + "/",
    timeout: 5000
  });

router.post('/post_msg', async function (req, res) {
    const { CHAT_TYPE, MSG, IPADDRESS, USERID, AVATAR_MEDIUM, AVATAR_SMALL, USERNAME } = req.body
    var curtime = dateFormat(new Date(), "yyyy-mm-dd HH:MM:ss")
    var data = {
        msg: MSG,
        avatarmedium: AVATAR_MEDIUM,
        avatar: AVATAR_SMALL,
        username: USERNAME,
        curtime: curtime,
        type: CHAT_TYPE
    }
    console.log(data)

    var ret = await instance.post("post_msg", data).then(response => {
        console.log("Backend ret: " + response.data.error_code)
        if(response.data != null && response.data.error_code == 0) {
            return true
        } else {
            return false
        }
    }).catch(error => {
        return false
    })
    if(ret) {
        var chat_data = {}
        chat_data["CHAT_TYPE"] = CHAT_TYPE
        chat_data["CREATE_TIME"] = curtime
        chat_data["UPDATE_TIME"] = curtime
        chat_data["MSG"] = MSG
        chat_data["IPADDRESS"] = IPADDRESS
        chat_data["USERID"] = USERID

        console.log(chat_data)

        chatModel.add(chat_data)
        return res.json({
            code: 20000,
            data: {
                error_code: 0
            }
        })
    }
    else {
        console.log("fail")

        return res.json({
            code: 20000,
            data: {
                error_code: 1
            }
        })
    }
    // $host = CHAT_SERVER_URL."post_msg";
    // $curtime = time();
    // $param_data = array();
    // $param_data['msg'] = $_POST['msg'];
    // $param_data['avatarmedium'] = $this->session->userdata('AVATAR_MEDIUM');
    // $param_data['avatar'] = $this->session->userdata('AVATAR_SMALL');
    // $param_data['username'] = $this->session->userdata('USERNAME');
    // $param_data['curtime'] = $curtime;
    // $param_data['type'] = $_POST['type'];

    // $json = json_encode($param_data);
    // $ch = curl_init();
    // curl_setopt($ch, CURLOPT_HEADER, 0);
    // curl_setopt($ch, CURLOPT_URL, $host);
    // curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    // curl_setopt($ch, CURLOPT_POST, 1);
    // curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    // curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
    // curl_setopt($ch, CURLOPT_HTTPHEADER, array(    //<--- Added this code block
    //         'Content-Type: application/json',
    //         'Content-Length: ' . strlen($json))
    // );

    // $data = curl_exec($ch);
    // $ret = json_decode($data , true);
    // if($ret['error_code'] == 0) {

    //     $insert_data = array(
    //         'CHAT_TYPE' => $_POST['type'] ,
    //         'CREATE_TIME' => $curtime ,
    //         'UPDATE_TIME' => $curtime ,
    //         'MSG' => $_POST['msg'],
    //         'IPADDRESS' => $this->input->ip_address(),
    //         'USERID' => $this->session->userdata('USERID')
    //     );

    //     $this->db->insert('chats' , $insert_data);
    //     echo json_encode( array('error_code' => 0) );	

    // }
    // else {
    //     echo json_encode( array('error_code' => 1) );	
    // }
});

router.post('/list', async function (req, res) {
    var chat_type = req.body.type
    console.log(chat_type)
    var chats = await chatModel.list(chat_type)
    return res.json({
        code: 20000,
        data: chats
    })
});
  
module.exports = router;
