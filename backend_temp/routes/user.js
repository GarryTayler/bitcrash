var express = require('express');
var router = express.Router();
var config = require('../src/config');
var rn = require('random-number');
var md5 = require('md5');
var nodemailer = require('nodemailer');
//new package
var fs = require("fs")
var path = require("path");
router.post('/forgot_user_password', function(req, res) {
  const {email , pass_token} = req.body
  var transporter = nodemailer.createTransport({
      host: 'smtp.zoho.com',
      port: 465,
      secure: true, // use SSL
      auth: {
          user: config.EMAIL,
          pass: config.EMAIL_PWD
      }
  });
  var mailOptions = {
    from: '<' + config.EMAIL + '>', // sender address (who sends)
    to: email, // list of receivers (who receives)
    subject: 'Reset Password Link', // Subject line
    text: 'Change your password', // plaintext body
    html: '<b><h3>We have received a password change request for your bitcrash account</h3></b><br>' +
    '<h3>If you did not ask to change your password, then you can ignore this email and your password will not be changed.</h3><br> ' +
    '<h3><a href="https://www.bitcrash.co.za/#/reset_password?pass_token=' + pass_token + '" target="R">Reset Password</a></h3>' // html body
  };
  console.log(mailOptions)
  transporter.sendMail(mailOptions, function(error, info){
    if(error){
        console.log(error);
    }
    else
      console.log('Message sent: ' + info.response);  
  });
  res.json({
    code: 20000,
    message: 'An email with password reset instructions has been sent to your email address, if it exists on our system.',
    status: 'success',
    data: null
  })
})

module.exports = router;
