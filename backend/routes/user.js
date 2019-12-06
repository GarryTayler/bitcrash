var express = require('express');
var router = express.Router();
var MD5 = require('md5');

var userModel = require('./model/user');
router.post('/login', function (req, res) {
  const { username, email, password } = req.body

  userModel.getUserInfo({ email: email, password: password }, function (rows) {
    var token = null
    if(rows.length < 1) {
      return res.json({
        code: 60204,
        message: 'Incorrect username/email and / or password. Do you need help loggin in?'
      })
    } else {
      if(rows[0]['STATE'] != '0') {
        return res.json({
          code: 60204,
          message: 'You are not allowed to use this account. Do you need support?'
        })
      } else {
        token = rows[0]['API_TOKEN']
      }
    }

    var data = rows[0]
    data["token"] = rows[0]['API_TOKEN']
    data["id"] = rows[0]['ID']
    return res.json({
      code: 20000,
      data: data
    });
  });
});

router.post('/info', function (req, res) {
  const { token } = req.body

  console.log(token)
  userModel.getUserInfo({ token: token }, function (rows) {
    console.log(rows)
    if(rows.length < 1 || rows[0]['STATE'] != 0) {
      return res.json({
        code: 50008,
        message: 'Login failed, unable to get user details.'
      })
    }

    return res.json({
      code: 20000,
      data: rows[0]
    });
  });
});

router.post('/logout', function (req, res) {
  return res.json({
    code: 20000,
    data: ''
  });
});

module.exports = router;
