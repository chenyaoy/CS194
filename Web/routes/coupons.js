var express = require('express');
var Parse = require('parse/node');
Parse.initialize("codeconomy");
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';
Parse.masterKey = 'flatstanley';
Parse.User.enableRevocableSession();

var bodyParser = require('body-parser');

var router = express.Router();
router.use(bodyParser.json()); // support json encoded bodies
router.use(bodyParser.urlencoded({ extended: true }));


function checkLogin(req, res) {
    return new Promise(function(resolve, reject) {
        if(req.session.token) {
            Parse.Cloud.useMasterKey();
            var sq = new Parse.Query('_Session');
            sq.equalTo('sessionToken', req.session.token).include('user');
            sq.first().then(function(sessionResult) {
                if (!sessionResult) {
                    reject("No matching session");
                } else {
                    res.locals.session = req.session;
                    res.locals.user = sessionResult.get('user');
                    resolve(res);
                }
            }, function(err) {
                reject("Error or no matching session: " + err.message);
            });
        } else {
            reject("User not logged in");
        }
    });
}

router.get('/postCoupon', function(req, res) {
    checkLogin(req, res).then(function(res) {
        res.render('pages/post_coupon', {user:res.locals.user});
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.post('/postCoupon/submit', function(req, res) {
    checkLogin(req, res).then(function(res) {
        if(validateRequiredCouponParams(req)) {
            var Coupon = Parse.Object.extend("Coupon");
            var coupon = new Coupon();
            coupon.set("storeName", req.body.store);
            coupon.set("couponDescription", req.body.couponDescription);
            coupon.set("expirationDate",
                req.body.expireDate.length == 0 ? null : new Date(req.body.expireDate));
            coupon.set("additionalInfo", req.body.additionalInfo);
            coupon.set("price", parseInt(req.body.price));
            coupon.set("code", req.body.code);
            coupon.set("category", req.body.category);
            coupon.set("status", 1);
            coupon.set("deleted", false);
            coupon.set("seller", res.locals.user);
            coupon.save(null, {
                success: function(coupon) {
                    res.redirect('/users/myCoupons/selling');
                },
                error: function(coupon, error) {
                    console.log("Coupon upload failed. Please try again. " + error.message);
                    res.render('pages/error_try_again');
                }
            });
        } else {
            console.log("Error in provided coupon data. Please verify that all information was entered correctly.");
            res.render('pages/error_try_again');
        }
    }, function(err) {
        res.redirect('/users/login');
    });
});


router.post('/purchaseCoupon', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Coupon = Parse.Object.extend("Coupon");
        var query = new Parse.Query(Coupon).include("seller");
        query.get(req.body.id, {
            success: function(result) {
                var seller = result.get("seller");
                var price = result.get("price");
                if(price > res.locals.user.get("credits")) {
                    res.render("pages/error_try_again");
                }
                var Transaction = Parse.Object.extend("Transaction");
                var transaction = new Transaction();
                transaction.set("buyer", res.locals.user);
                transaction.set("seller", seller);
                transaction.set("coupon", result);
                transaction.set("reviewDescription", null);
                transaction.set("stars", 0);
                transaction.set("transactionDate", new Date());
                transaction.save(null, {
                    success: function(transaction) {
                        Parse.Cloud.useMasterKey();
                        seller.set("credits", seller.get("credits") + price);
                        res.locals.user.set("credits", res.locals.user.get("credits") - price);
                        result.set("status", 0);
                        var toSave = [result, res.locals.user, seller];
                        Parse.Object.saveAll(toSave, {
                            success: function() {
                                res.redirect('/coupons/coupon?id=' + result.id);
                            },
                            error: function() {
                                res.render("pages/error_try_again");
                            }
                        });
                    },
                    error: function(transaction, error) {
                        res.send("Transaction failed. Please try again. " + error.message)
                    }
                });
            },
            error: function(error) {
                console.log(error.message);
                res.render("pages/error_try_again");
            }
        });
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/coupon', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Coupon = Parse.Object.extend("Coupon");
        var query = new Parse.Query(Coupon).include("seller");
        query.get(req.query.id, {
            success: function(result) {
                var Transaction = Parse.Object.extend("Transaction");
                var transactionQuery = new Parse.Query(Transaction);
                transactionQuery.equalTo("coupon", result).include("buyer").include("seller");
                var isBuyer = false;
                var needsReview = true;
                var isSeller = result.get("seller").id == res.locals.user.id;
                transactionQuery.first().then(function(transactionResult){
                    if(transactionResult) {
                        isBuyer = transactionResult.get("buyer").id == res.locals.user.id;
                        needsReview = transactionResult.get("stars") == 0;
                    }
                    res.render('pages/display_coupon', {user:res.locals.user, coupon:result, 
                        isBuyer:isBuyer, needsReview:needsReview, isSeller:isSeller});
                });
            },
            error: function(object, error) {
                res.render('pages/error_try_again');
            }
        });
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/postReview', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Coupon = Parse.Object.extend("Coupon");
        var query = new Parse.Query(Coupon);
        query.get(req.query.id, {
            success: function(result) {
                var Transaction = Parse.Object.extend("Transaction");
                var transactionQuery = new Parse.Query(Transaction);
                transactionQuery.equalTo("coupon", result).include("buyer");
                var isBuyer = false;
                var needsReview = true;
                transactionQuery.first().then(function(transactionResult){
                    if(transactionResult) {
                        isBuyer = transactionResult.get("buyer").id == res.locals.user.id;
                        needsReview = transactionResult.get("stars") == 0;
                        if(isBuyer && needsReview) {
                            res.render('pages/post_review', {user:res.locals.user, coupon:result,
                            transaction:transactionResult});
                        } else {
                            res.render('pages/error_try_again');
                        }
                    } else {
                        res.render('pages/error_try_again');
                    }
                });
            },
            error: function(object, error) {
                res.render('pages/error_try_again');
            }
        });
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.post('/postReview/submit', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Transaction = Parse.Object.extend("Transaction");
        var transactionQuery = new Parse.Query(Transaction);
        transactionQuery.get(req.body.transaction_id, {
            success: function(result) {
                result.set("stars", parseInt(req.body.radios));
                result.set("reviewDescription", req.body.comment.length == 0 ? null : req.body.comment);
                result.save(null, {
                    success: function(coupon) {
                        res.redirect('/coupons/coupon?id=' + result.get("coupon").id);
                    },
                    error: function(coupon, error) {
                        console.log("Posting review failed: " + error.message);
                        res.render('pages/error_try_again');
                    }
                });
            },
            error: function(object, error) {
                res.render('pages/error_try_again');
            }
        });
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/clothing', function(req, res) {
    checkLogin(req, res).then(function(res) {
        query = unsoldQuery();
        query.equalTo("category", "Clothing")
        serveQuery(query, req, res, "Clothing");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/electronics', function(req, res) {
    checkLogin(req, res).then(function(res) {
        query = unsoldQuery();
        query.equalTo("category", "Electronics")
        serveQuery(query, req, res, "Electronics");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/concerts', function(req, res) {
    checkLogin(req, res).then(function(res) {
        query = unsoldQuery();
        query.equalTo("category", "Concerts")
        serveQuery(query, req, res, "Concerts");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/food', function(req, res) {
    checkLogin(req, res).then(function(res) {
        query = unsoldQuery();
        query.equalTo("category", "Food")
        serveQuery(query, req, res, "Food");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/other', function(req, res) {
    checkLogin(req, res).then(function(res) {
        query = unsoldQuery();
        query.equalTo("category", "Other")
        serveQuery(query, req, res, "Other");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/explore', function(req, res) {
    checkLogin(req, res).then(function(res) {
        query = unsoldQuery();
        serveQuery(query, req, res, "All");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/', function(req, res) {
    checkLogin(req, res).then(function(res) {
        res.render('pages/coupon_home',{user:res.locals.user});
    }, function(err) {
        res.redirect('/users/login');
    });
});

function unsoldQuery() {
    var Coupon = Parse.Object.extend("Coupon");
    var expDate = new Parse.Query(Coupon);
    expDate.greaterThan("expirationDate", new Date());
    var noExpDate = new Parse.Query(Coupon);
    noExpDate.equalTo("expirationDate", null);
    var query = Parse.Query.or(expDate, noExpDate);
    query.equalTo("status", 1);
    query.equalTo("deleted", false);
    return query;
}

function serveQuery(query, req, res, category) {
    query.find({
        success: function(coupons) {
            res.render('pages/explore_coupons', {coupons:coupons, user:res.locals.user, category:category});
        },
        error: function(error) {
            res.render('pages/error_try_again');
        }
    });
}

function validateRequiredCouponParams(req) {
    if(typeof(req.body.store) == 'undefined') {
        return false;
    }
    if(typeof(req.body.couponDescription) == 'undefined') {
        return false;
    }
    if(req.body.expireBool == 'Yes' && req.body.expireDate.length == 0) {
        return false;
    }
    if(req.body.expireDate.length != 0 && new Date(req.body.expireDate) < new Date()) {
        return false;
    }
    if(typeof(req.body.price) == 'undefined' || req.body.price < 0) {
        return false;
    }
    if(typeof(req.body.code) == 'undefined') {
        return false;
    }
    return true;
}

module.exports = router;
