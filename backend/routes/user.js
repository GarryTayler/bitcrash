var express = require('express');
var router = express.Router();
var model = require('./model/user');
var variableModel = require('./model/variable');
var config = require('../src/config');
var rn = require('random-number');
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

var generateReferralCode = function (length = 6) {
  characters = '0123456789';
  charactersLength = characters.length;
  randomString = '';
  var options = {
      min: 0
      , max: charactersLength - 1
      , integer: true
  }
  for (var i = 0; i < length; i++) {
      randomString += characters[rn(options)];
  }
  return randomString;
}

router.post('/signup', async function (req, res) {
  const { username, email, password, referral_code_p } = req.body
  var referral_code = ''
  try {
    var user_info = await model.checkUsername(username)
    if(user_info.length > 0) {
      return res.json({
        code: 50000,
        status: 'fail',
        msg: 'This username is already registered.',
        data: null
      });
    }
    user_info = await model.checkEmail(email)
    if(user_info.length > 0) {
      return res.json({
        code: 50000,
        status: 'fail',
        msg: 'This email is already registered.',
        data: null
      });
    }
    while(1) {
      referral_code = generateReferralCode();
	    const return_val = await model.checkReferralCode(referral_code)
      if(return_val.length < 1)
        break;
    }
    var ret = await model.signup({ username: username, email: email, password: password, referral_code: referral_code, referral_code_p: referral_code_p })
    if (ret.code == false) {
      return res.json({
        code: 50000,
        msg: 'Signup Failed',
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
  } catch(err) {
    return res.json({
      code: 401,
      status: 'fail',
      msg: null,
      data: null
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

router.post('/get_user_referralcode' , async function (req, res) {
  try {
    const referral_value = await variableModel.getReferralPercentage();
    const referral_code = await model.getReferralCode(req.body.user_id);
    const referral_link = config.MAIN_REFERRAL_PREFIX + "?r=" + referral_code;
    return res.json({
      code: 20000,
      message: null,
      status: 'success',
      data: {
        referral_value : referral_value,
        referral_code : referral_code,
        referral_link : referral_link
      }
    })
  } catch (err) {
    return res.json({
      code: 401,
      message: null,
      status: 'fail',
      data: null
    })
  }
});

router.post('/get_user_referral_value' , async function (req, res) {
  try {
    const referral_value = await variableModel.getReferralPercentage();
    return res.json({
      code: 20000,
      message: null,
      status: 'success',
      data: {
        referral_value : referral_value
      }
    })
  } catch (err) {
    return res.json({
      code: 401,
      message: null,
      status: 'fail',
      data: null
    })
  }
});
router.post('/get_withdraw_page_data' , function (req, res) {
  model.getUserBalance({who: req.body.user_id} , function (err, modelResult) {
      if(err) {
        return res.json({
          code: 401,
          message: null,
          status: 'fail',
          data: null
        })
      }
      var wallet = 0;
      if(modelResult.content.hasOwnProperty('WALLET')) {
        wallet = modelResult.content.WALLET;
      }
      variableModel.getWithdrawalFee()
      .then((withdraw_fee) => {
          return res.json({
            code: 20000,
            message: null,
            status: 'success',
            data: {
              wallet: wallet ,
              withdraw_fee: withdraw_fee
            }
          })
      })
      .catch((err) => {
          return res.json({
            code: 401,
            message: null,
            status: 'fail',
            data: null
          })
      })
  })
});
router.post('/update_referral_value' , async function (req, res) {
  try {
    const referral_value = await variableModel.updateReferralPercentage(req.body.referral_value);
    return res.json({
      code: 20000,
      message: null,
      status: 'success',
      data: null
    })
  } catch (err) {
    return res.json({
      code: 401,
      message: null,
      status: 'fail',
      data: null
    })
  }
});

module.exports = router;
