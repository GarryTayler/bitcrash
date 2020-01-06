var express = require('express');
var router = express.Router();
var config = require('./../src/config')
var btcDepositAddressModel = require('./model/btc_deposit_address')
var userModel = require('./model/user')
var txnModel = require('./model/txn')
var request = require('request');

var bitcoin = require("bitcoinjs-lib");
var bigi    = require("bigi");
var buffer  = require('buffer');
router.post('/get_deposit_address', function (req, res , next) {
    var who = req.body.who;
    if( parseInt(who) == 0) {
        var resp = {
            code: 401,
            status: 'failed',
            msg: 'You should log in first.',
            res: null
        };
        return res.json(resp);
    }
    btcDepositAddressModel.getDepositAddressData({who: who}, function (err, modelResult) {
        if(err) {
            var resp = {
                code: 401,
                status: 'failed',
                msg: null,
                res: null
            };
            return res.json(resp);
        } else {
            if(modelResult.length > 0){
                var resp = {
                    code: 20000,
                    status: 'success',
                    msg: null,
                    res: modelResult.content.INPUT_ADDRESS
                };
                return res.json(resp);
            } else {
                var params = {
                    "destination" : config.BTC_SITE_WALLET_ADDRESS,
                    "callback_url" : config.BLOCKCYPHER_CALLBACK_HOST_URL + "api/btc/deposit/" + who
                };
                var options = {
                    method: 'POST',
                    url: 'https://api.blockcypher.com/v1/btc/main/payments?token=' + config.BLOCKCYPHER_TOKEN,
                    body: params,
                    json: true
                };
                request(options , function(err, response, apiResult) {
                    btcDepositAddressModel.insertNewDepositAddress({who:who, input_address:apiResult.input_address, destination:apiResult.destination, input_address_id:apiResult.id} , function(err , subModelResult) {
                        if (err) {
                            var resp = {
                                code: 401,
                                status: 'failed',
                                msg: null,
                                res: null
                            };
                            return res.json(resp);
                        } else {
                            var resp = {
                                code: 20000,
                                status: 'success',
                                msg: null,
                                address: apiResult.input_address
                            };
                            return res.json(resp);
                        }
                    })
                });
            }
        }
    })
})

router.post('/deposit/:who', function(req, res, next) {
    var who = req.params.who;
    var satoshi_amount = req.body.value;
    var amount = satoshi_amount / Math.pow(10, 8);
    //The transaction hash representing the initial payment to the input_address.
    var tx_hash = req.body.input_transaction_hash;
    //The transaction hash of the generated transaction that forwards the payment from the input_address to the destination.
    var destination_txhash = req.body.transaction_hash;

    var options = {
        method: 'GET',
        url: 'https://api.blockcypher.com/v1/btc/main/txs/' + destination_txhash
    };

    request(options, function (error, response, body) {
        if (error) {
            var resp = {
                code: 401,
                status: 'failed',
                msg: null,
                res: null
            };
            return res.json(resp);
        } else {
            userModel.updateBalance({who: who, amount: amount}, function(err, modelResult) {
                if (!err) {
                    var txnData = {
                        who : who,
                        type : 1,
                        amount : amount,
                        fees : 0,
                        detail : tx_hash,
                        txhash : destination_txhash
                    }
                    txnModel.insertTxn(txnData , function(err , subModelResult) {
                        if (err) {
                            var resp = {
                                code: 401,
                                status: 'failed',
                                msg: null,
                                res: null
                            };
                            return res.json(resp);
                        } else {
                            var resp = {
                                code: 20000,
                                status: 'success',
                                msg: null,
                                res: null
                            };
                            return res.json(resp);
                        }
                    });
                }
                else {
                    var resp = {
                        code: 401,
                        status: 'failed',
                        msg: null,
                        res: null
                    };
                    return res.json(resp);
                }
            });
        }
    });
})

router.post('/withdraw' , function(req, res, next) {
    var who = req.body.who;
    var to_address = req.body.to_address;
    var amount = parseFloat(req.body.amount);
    var amount_coins = parseInt(Math.pow(10 , 6) * amount);
    var rem_amount = -1 * amount;
    var return_data = true;
    var mainAddressData;

    if(amount >= config.BTC_min_withdraw_amount) {
        if(return_data == true) {
            var check_user_balance = new Promise(function(check_user_balance_resolve, check_user_balance_reject) {
                userModel.getUserBalance({who: who} , function (err, modelResult) {
                    var available_balance = modelResult.WALLET;
                    if(available_balance < amount_coins){
                        check_user_balance_resolve(false);
                    }else{
                        check_user_balance_resolve(true);
                    }
                })
            });

            check_user_balance.then(function(result) {
                return_data = result;
                if(return_data == true) {
                    var check_to_address_exists = new Promise(function(check_to_address_exists_resolve, check_to_address_exists_reject) {
                        var options = {
                            method: 'GET',
                            url: 'https://api.blockcypher.com/v1/btc/main/addrs/' + to_address,
                            json: true
                        };
                        request(options, function (err, response, apiResult) {
                            if(err){
                                check_to_address_exists_resolve(false);
                            }else{
                                check_to_address_exists_resolve(true);
                            }
                        });
                    });
                    check_to_address_exists.then(function(result) {
                        return_data = result;
                        if(return_data == true) {
                            var check_with_deposit_address = new Promise(function(check_with_deposit_address_resolve, check_with_deposit_address_reject) {
                                btcDepositAddressModel.getDepositAddressData({who: who}, function (err, modelResult) {
                                    if(err){
                                        check_with_deposit_address_resolve(false);
                                    }else{
                                        if(modelResult.length == 0){
                                            check_with_deposit_address_resolve(true);
                                        }else{
                                            if(modelResult.content.input_address == to_address){
                                                check_with_deposit_address_resolve(false);
                                            }else{
                                                check_with_deposit_address_resolve(true);
                                            }
                                        }
                                    }
                                })
                            });

                            check_with_deposit_address.then(function(result) {
                                return_data = result;
                                if(return_data == true) {
                                    if(config.BTC_SITE_WALLET_ADDRESS == to_address) {
                                        res.json({
                                            code: 401,
                                            status: 'failed',
                                            msg : "blocked address"
                                        });
                                    }
                                    else {
                                        var update_wallet = new Promise(function(update_wallet_resolve, update_wallet_reject) {
                                            usersModel.updateBalance({who: who, amount: rem_amount}, function (err, modelResult) {
                                                if(err){
                                                    update_wallet_resolve(false);
                                                }else{
                                                    update_wallet_resolve(true);
                                                }
                                            })
                                        });
                                        update_wallet.then(function(result) {
                                            return_data = result;
                                            if(return_data == true) {

                                                var send_txn = new Promise(function(send_txn_resolve) {
                                                    var send_amount = amount - config.BTC_withdraw_fee;
                                                    var satoshi_amount = send_amount * Math.pow(10, 8);
                                                    var satoshi_fee = config.BTC_withdraw_fee * Math.pow(10, 8);
                                                    var newtx = {
                                                        inputs: [{addresses: [config.BTC_SITE_WALLET_ADDRESS]}],
                                                        outputs: [{addresses: [to_address], value: satoshi_amount}],
                                                        fees: satoshi_fee
                                                    };
                                                    var keys = new bitcoin.ECPair(bigi.fromHex(config.BTC_SITE_PRIVATE_KEY));
                                                    var options = {
                                                        method: 'POST',
                                                        url: 'https://api.blockcypher.com/v1/bcy/test/txs/new',
                                                        body: newtx,
                                                        json: true
                                                    };

                                                    request(options, function (err, response, tx) {
                                                        if(err) {
                                                            send_txn_resolve(false);
                                                        } else {
                                                            tx.pubkeys = [];
                                                            tx.signatures = tx.tosign.map(function (tosign, n) {
                                                                tx.pubkeys.push(keys.getPublicKeyBuffer().toString("hex"));
                                                                return keys.sign(new buffer.Buffer(tosign, "hex")).toDER().toString("hex");
                                                            });
                                                            var options = {
                                                                method: 'POST',
                                                                url: 'https://api.blockcypher.com/v1/bcy/test/txs/send',
                                                                body: tx,
                                                                json: true
                                                            };
                                                            request(options, function (err, response, finaltx) {
                                                                if (err){
                                                                    send_txn_resolve(false);
                                                                }else{
                                                                    if (finaltx.errors){
                                                                        send_txn_resolve(false);
                                                                    }else{
                                                                        send_txn_resolve(finaltx.tx.hash);
                                                                    }
                                                                }
                                                            });
                                                        }
                                                    });
                                                });

                                                send_txn.then(function(result) {
                                                    if(result) {
                                                        var txHash = result;
                                                        var txnData = {
                                                            who : who,
                                                            type : 2,
                                                            amount : amount,
                                                            fees : config.BTC_withdraw_fee,
                                                            detail : to_address,
                                                            txhash : txHash
                                                        }
                                                        txnModel.insertTxn(txnData , function(err , subModelResult) {
                                                            if (err) {
                                                                var resp = {
                                                                    code: 401,
                                                                    status: 'failed',
                                                                    msg: null,
                                                                    res: null
                                                                };
                                                                return res.json(resp);
                                                            } else {
                                                                var resp = {
                                                                    code: 20000,
                                                                    status: 'success',
                                                                    msg: null,
                                                                    res: txHash
                                                                };
                                                                return res.json(resp);
                                                            }
                                                        });
                                                    } else {
                                                        res.json({
                                                            code: 401,
                                                            status: 'failed',
                                                            msg : "service limited"
                                                        });
                                                    }
                                                });
                                            }
                                            else {
                                                res.json({
                                                    code: 401,
                                                    status: 'failed',
                                                    msg : "service limited"
                                                });
                                            }
                                        });
                                    }
                                } else if(return_data == false) {
                                    res.json({
                                        code: 401,
                                        status: 'failed',
                                        msg : "disabled address"
                                    });
                                } else {
                                    res.json({
                                        code: 401,
                                        status: 'failed',
                                        msg : "service limited"
                                    });
                                }
                            });
                        } else {
                            res.json({
                                code: 401,
                                status: 'failed',
                                msg : "invalid address"
                            });
                        }
                    });
                }
            });
        }
    } else {
        res.json({
            code: 401,
            status: 'failed',
            msg : "amount should be larger than " + config.BTC_min_withdraw_amount
        });
    }
})

module.exports = router;