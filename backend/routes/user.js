var express = require('express');
var router = express.Router();
var model = require('./model/user');
var variableModel = require('./model/variable');
var txnModel = require('./model/txn')
var config = require('../src/config');
var rn = require('random-number');
var md5 = require('md5');

//new package
var fs = require("fs")
var multer = require("multer")
var path = require("path");
const upload = multer({
  dest: config.IMAGE_TEMP_DEST
  // you might also want to set some limits: https://github.com/expressjs/multer#limits
});

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

var generateFileName = (length = 20) => {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}

var getFileName = (upload_path) => {
  var res = upload_path.split("/")
  return res[res.length-1]
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
        message: 'This username is already registered.',
        data: null
      });
    }
    user_info = await model.checkEmail(email)
    if(user_info.length > 0) {
      return res.json({
        code: 50000,
        status: 'fail',
        message: 'This email is already registered.',
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
        message: 'Signup Failed',
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
      message: 'Api Request Failed.',
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
      message: 'Api Request Failed.',
      status: 'fail',
      data: null
    })
  }
});

router.post('/get_user_referral_value' , async function (req, res) {
  try {
    const referral_value = await variableModel.getReferralPercentage();
    const withdraw_fee = await variableModel.getWithdrawalFee();
    return res.json({
      code: 20000,
      message: null,
      status: 'success',
      data: {
        referral_value : referral_value,
        withdraw_fee : withdraw_fee
      }
    })
  } catch (err) {
    return res.json({
      code: 401,
      message: 'Api Request Failed.',
      status: 'fail',
      data: null
    })
  }
});

router.post('/get_profile_page_data' , async function (req, res) {
  try {
    const user_profile = await model.getUserProfile(req.body.user_id)
    const deposit_sum = await txnModel.getDepositSum(req.body.user_id)
    const withdraw_sum = await txnModel.getWithdrawSum(req.body.user_id)
    return res.json({
      code: 20000,
      message: null,
      status: 'success',
      data: {
        withdraw_sum : withdraw_sum,
        deposit_sum : deposit_sum,
        avatar: user_profile[0].AVATAR,
        wallet: user_profile[0].WALLET,
        join_time: user_profile[0].CREATE_TIME,
        user_name: user_profile[0].USERNAME,
        email: user_profile[0].EMAIL 
      }
    })

  } catch(err) {
      return res.json({
        code: 401,
        message: 'Api Request Failed.',
        status: 'fail',
        data: null
      }) 
  }
})

router.post('/get_withdraw_page_data' , function (req, res) {
  model.getUserBalance({who: req.body.user_id} , function (err, modelResult) {
      if(err) {
        return res.json({
          code: 401,
          message: 'Api Request Failed.',
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
            message: 'Api Request Failed.',
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
      message: 'Api Request Failed.',
      status: 'fail',
      data: null
    })
  }
});

router.post('/update_withdrawal_fee' , async function(req , res) {
    try {
      const return_val = await variableModel.updateWithdrawalFee(req.body.withdraw_fee);
      return res.json({
        code: 20000,
        message: null,
        status: 'success',
        data: null
      })
    } catch (err) {
      return res.json({
        code: 401,
        message: 'Api Request Failed.',
        status: 'fail',
        data: null
      })
    }
})

router.post('/update_username' , async function(req , res) {
  try {
    const { username , user_id } = req.body
    var user_info = await model.checkUsername(username)
    if(user_info.length > 0) {
      return res.json({
        code: 50000,
        status: 'fail',
        message: 'This username is already registered.',
        data: null
      });
    }
    else {
      var ret_code = await model.updateUserProfile({USERNAME: username} , {ID: user_id});
      return res.json({
        code: 20000,
        message: null,
        status: 'success',
        data: null
      })
    }
  } catch(error) {
      return res.json({
        code: 401,
        message: 'Api Request Failed.',
        status: 'fail',
        data: null
      })
  }
}) 

router.post('/update_useremail' , async function(req , res) {
  try {
    const { useremail , user_id } = req.body
    var user_info = await model.checkEmail(useremail)
    if(user_info.length > 0) {
      return res.json({
        code: 50000,
        status: 'fail',
        message: 'This email is already registered.',
        data: null
      });
    }
    else {
      var ret_code = await model.updateUserProfile({EMAIL: useremail} , {ID: user_id});
      return res.json({
        code: 20000,
        message: null,
        status: 'success',
        data: null
      })
    }
  } catch(error) {
      return res.json({
        code: 401,
        message: 'Api Request Failed.',
        status: 'fail',
        data: null
      })
  }
})

router.post('/update_password' , function(req , res) {
  const {old_password , new_password , user_id} = req.body

  model.getUserInfo({ password: old_password , user_id: user_id }, function (rows) {
    if(rows.length < 1) {
      return res.json({
        code: 50000,
        status: 'fail',
        message: 'Your current password is incorrect.',
        data: null
      }); 
    }
    model.updateUserProfile({password: md5(new_password)} , {ID: user_id})
    .then((result) => {
        return res.json({
          code: 20000,
          message: null,
          status: 'success',
          data: null
        })   
    })
    .catch((err) => {
        return res.json({
          code: 401,
          message: 'Api Request Failed.',
          status: 'fail',
          data: null
        })   
    })
  });
})

router.post('/update_avatar' , async function(req , res) {
  try {
    const { avatar , user_id } = req.body
    //getFileName
    var avatar_link = await model.getUserAvatarImage(user_id); 
    var fileName = getFileName(avatar_link)
    if(fileName !== 'general_profile.png') {
      fs.unlink(config.AVATAR_STORE_PATH + fileName , (err) => {
      });
    }
    var ret_code = await model.updateUserProfile({AVATAR: avatar} , {ID: user_id});
    return res.json({
      code: 20000,
      message: null,
      status: 'success',
      data: null
    })
  } catch(error) {
      return res.json({
        code: 401,
        message: 'Api Request Failed.',
        status: 'fail',
        data: null
      })
  }
})

router.post("/upload_avatar",
  upload.single("file" /* name attribute of <file> element in your form */),
  (req, res) => {
    const tempPath = req.file.path;
    const imageFileName = generateFileName() + path.extname(req.file.originalname).toLowerCase();
    const targetPath = config.AVATAR_STORE_PATH + imageFileName;
    if (path.extname(req.file.originalname).toLowerCase() === ".png" || path.extname(req.file.originalname).toLowerCase() === ".jpg") {
      fs.rename(tempPath, targetPath, err => {
          if (err) {
            return res.json({
              code: 401,
              message: 'Api Request Failed.',
              status: 'fail',
              data: null
            })         
          } 
          return res.json({
            code: 20000,
            message: null,
            status: 'success',
            data: {
              avatar: config.HOST + '/img/uploads/avatar/' + imageFileName
            }
          })   
      });
    } else {
      fs.unlink(tempPath, err => {
        if (err)  {
          return res.json({
              code: 401,
              message: 'Api Request Failed.',
              status: 'fail',
              data: null
          })         
        }
        return res.json({
            code: 500,
            message: 'Only .png,jpg files are allowed!',
            status: 'fail',
            data: null
        })   
      });
    }
  }
);

module.exports = router;
