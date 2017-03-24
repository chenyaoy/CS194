var express = require('express');
var Parse = require('parse/node');
Parse.initialize("codeconomy");
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';
Parse.masterKey = 'flatstanley';

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

router.get('/myCoupons/purchased', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Transaction = Parse.Object.extend("Transaction");
        var query = new Parse.Query(Transaction);
        query.equalTo("buyer", res.locals.user).include("coupon");
        query.find({
            success: function(transactions) {
                var coupons = [];
                for (var i = 0; i < transactions.length; i++) {
                    coupon = transactions[i].get("coupon");
                    coupons.push(coupon);
                }
                res.render('pages/explore_coupons', {coupons:coupons, user:res.locals.user, category:"Purchased"});
            },
            error: function(error) {
                res.render('pages/error_try_again');
            }
        });
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/myCoupons/selling', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Coupon = Parse.Object.extend("Coupon");
        var expDate = new Parse.Query(Coupon);
        expDate.greaterThan("expirationDate", new Date());
        var noExpDate = new Parse.Query(Coupon);
        noExpDate.equalTo("expirationDate", null);
        var query = Parse.Query.or(expDate, noExpDate);
        query.equalTo("seller", res.locals.user);
        query.equalTo("deleted", false);
        query.equalTo("status", 1);
        serveQuery(query, req, res, "Listed");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/myCoupons/sold', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Coupon = Parse.Object.extend("Coupon");
        var query = new Parse.Query(Coupon);
        query.equalTo("seller", res.locals.user);
        query.equalTo("deleted", false);
        query.equalTo("status", 0);
        serveQuery(query, req, res, "All");
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.post('/addCredits', function(req, res) {
    Parse.Cloud.useMasterKey();
    var User = Parse.Object.extend("_User");
    var username = req.query.username;
    var credits = req.query.credits;
    var query = new Parse.Query(User);
    query.equalTo("username", username);
    query.include("credits");
    query.find({
        success: function (user) {
            user = user[0];
            user.set("credits", user.get("credits") + parseInt(credits));
            user.save({useMasterKey:true}, {
                success: function (user) {
                    res.send("successfully added " + credits + " credits")
                },
                error: function(user, error) {
                    res.send(error);
                },
            });
        },
        error: function (object, error) {
            res.send("query for user failed. error: " + error);
        }
    });
});

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

router.get('/viewComments', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var User = Parse.Object.extend("_User");
        var query = new Parse.Query(User);
        query.get(req.query.id, {
            success: function(result) {
                var Transaction = Parse.Object.extend("Transaction");
                var tq = new Parse.Query(Transaction);
                tq.equalTo("seller", result);
                tq.notEqualTo("stars", 0);
                tq.find({
                    success: function(transactions) {
                        res.render('pages/users/display_reviews', {transactions:transactions, displayUser:result, user:res.locals.user});
                    },
                    error: function(error) {
                        res.render('pages/error_try_again');
                    }
                });
            },
            error: function(error) {
                res.render('pages/error_try_again');
            }
        });
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/', function(req, res) {
    res.render('pages/index');
});

router.get('/login', function(req, res) {
    checkLogin(req, res).then(function(res) {
        res.redirect('/coupons');
    }, function(err) {
        res.render('pages/users/login');
    });
});

router.post('/login/submit', function(req, res) {
    Parse.User.logIn(req.body.username, req.body.password, {
      success: function(user) {
        req.session.token = user.getSessionToken();
        res.redirect('/coupons');
      },
      error: function(user, error) {
        res.render('pages/users/login_error', {error:error});
      }
    });
});

router.get('/signup', function(req, res) {
    res.render('pages/users/signup');
});

router.post('/signup/submit', function(req, res) {
    if(req.body.displayName.length == 0) {
        var error = {message:"Please let us know what to call you."};
        res.render('pages/users/signup_error', {error:error});
    } else {
        var user = new Parse.User();
        user.set("username", req.body.username);
        user.set("password", req.body.password);
        user.set("email", req.body.email);
        user.set("displayName", req.body.displayName);
        user.set("credits", 50);

        user.signUp(null, {
          success: function(user) {
            req.session.token = user.getSessionToken();
            res.redirect("/users/myprofile");
          },
          error: function(user, error) {
            res.render('pages/users/signup_error', {error:error});
          }
        });
    }
});

function formatDate(date) {
    var monthNames = [
        "January", "February", "March",
        "April", "May", "June", "July",
        "August", "September", "October",
        "November", "December"
    ];

    var day = date.getDate();
    var monthIndex = date.getMonth();
    var year = date.getFullYear();

    return monthNames[monthIndex] + ' ' + day + ',' + ' ' + year;
}

router.get('/user', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var User = Parse.Object.extend("_User");
        var query = new Parse.Query(User);
        query.get(req.query.id, {
            success: function(result) {
                var Transaction = Parse.Object.extend("Transaction");
                var tq = new Parse.Query(Transaction);
                tq.equalTo("seller", result);
                tq.notEqualTo("stars", 0);
                tq.find({
                    success: function(transactions) {
                        var successful = 0;
                        var reviewed = false;
                        var total = transactions.length;
                        for (var i = 0; i < transactions.length; i++) {
                            if(transactions[i].get("stars") == 1) {
                                successful++;
                            }
                        }
                        if (total == 0) {
                            var score = 1.0;
                        } else {
                            var score = 1.0*successful/total;
                        }
                        
                        var memberSince = formatDate(result.createdAt);
                        res.render('pages/users/display_user', {
                            user:res.locals.user, 
                            displaying:result, 
                            score:score,
                            memberSince:memberSince
                        });
                    },
                    error: function(error) {
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

router.get('/myprofile', function(req, res) {
    checkLogin(req, res).then(function(res) {
        res.redirect('/users/user?id=' + res.locals.user.id);
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.get('/logout', function(req, res) {
    checkLogin(req, res).then(function(res) {
        res.render('pages/users/logout',{user:res.locals.user});
    }, function(err) {
        res.redirect('/users/login');
    });
});

router.post('/logout/submit', function(req, res) {
    req.session.token = null;
    res.redirect('/')
});

module.exports = router;
