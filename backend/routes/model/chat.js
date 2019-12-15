var db = require('./../../utils/database');
var dateFormat = require('dateformat');

var add = function(data) {
    var statement = db.statement("insert into", "chats", "(CHAT_TYPE, CREATE_TIME, UPDATE_TIME, MSG, IPADDRESS, USERID)", "", 
    "VALUES (" + "'" + data.CHAT_TYPE + "'" + "," + "'" + data.CREATE_TIME + "'" + "," + "'" + data.UPDATE_TIME + "'" + "," + "'" + data.MSG + "'" + "," + "'" + data.IPADDRESS + "'" + "," + data.USERID + ")")
    console.log(statement)
    db.cmd(statement)
}
var list = function (chat_type) {
    return db.list(db.statement("select chats.ID as id, chats.USERID as user_id, chats.CREATE_TIME, chats.MSG as message, users.USERNAME as user, users.AVATAR_SMALL as avatar from", "chats", 
        'LEFT JOIN users ON users.ID = chats.USERID',
        db.lineClause([
            {
                key: "chats.DEL_YN",
                val: "N"
            },
            {
                key: "chats.CHAT_TYPE",
                val: chat_type
            },
            {
                key: "chats.CREATE_TIME",
                val: dateFormat(new Date(), "yyyy-mm-dd") + " 00:00:00",
                opt: ">="
            }
        ], "and"), ""), true).then((chatItems) => {
            return chatItems
    })
    // $current_date = getCurrentTimeStamp();

    // $this->db->select("chats.CREATE_TIME , chats.MSG , users.USERNAME , users.AVATAR_SMALL as AVATAR");
    // $this->db->from($this->CHATS);
    // $this->db->join($this->USERS , 'users.ID = chats.USERID');
    // $this->db->where('chats.DEL_YN' , 'N');
    // $this->db->where('chats.CHAT_TYPE' , $type);
    // $this->db->where('chats.CREATE_TIME >=' , $current_date);
    // $this->db->limit(10);

    // $result = $this->db->get()->result_array();
        
    // $ret_data = array();
    // $ret_data['error_code'] = 0;
    // $ret_data['result'] = $result;
}
var chatModel = {
    add: add,
    list: list
}

module.exports = chatModel;