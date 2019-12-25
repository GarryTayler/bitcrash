var express = require('express');
var router = express.Router();

var model = require('./model/user');
router.post('/login', function (req, res) {
  const { search_key, password, token } = req.body
  var data = {}
  if (token !== undefined && token != null && token.length > 0) {
    data = {
      token: token
    }
  } else {
    data = {
      search_key: search_key,
      password: password
    }
  }
  model.getUserInfo(data, function (rows) {
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
  model.getUserInfo({ token: token }, function (rows) {
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
router.post('/signup', async function (req, res) {
  const { username, email, password } = req.body

  var ret = await model.signup({ username: username, email: email, password: password })
  if (ret.code == false) {
    return res.json({
      code: 50000,
      data: 'Signup Failed'
    });
  } else {
    return res.json({
      code: 20000,
      data: {
        user_id: ret.insert_id,
        token: ret.token
      }
    });
  }
});
router.post('/logout', function (req, res) {
  return res.json({
    code: 20000,
    data: ''
  });
});
router.post('/list', async function (req, res) {
  const { search_key, page, limit } = req.body
  var i_page = isNaN(parseInt(page)) ? 1 : parseInt(page)
  var i_limit = isNaN(parseInt(limit)) ? 1 : parseInt(limit)
  var data = await model.getList(search_key, i_page, i_limit)
  return res.json({
      code: 20000,
      data: data
  })
});
router.post('/update', function (req, res) {
  var ret = model.update(req.body)
  return res.json({
      code: ret ? 20000 : 60000,
      message: ret ? '' : 'Error',
      data: null
  })
});

module.exports = router;
