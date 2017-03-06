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
        query.equalTo("buyer", res.locals.user);
        query.find({
            success: function(transactions) {
                var coupons = [];
                for (var t = 0; t < transactions.length; t++) {
                    coupon_object = t.get("coupon");

                }
            },
            error: function(error) {
                res.render('pages/error_try_again');
            }
        });
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

router.get('/myCoupons', function(req, res) {
    checkLogin(req, res).then(function(res) {
        var Coupon = Parse.Object.extend("Coupon");
        var query = new Parse.Query(Coupon);
        query.equalTo("seller", res.locals.user);
        query.equalTo("deleted", false);
        query.equalTo("status", 1);
        serveQuery(query, req, res, "All");
    }, function(err) {
        res.redirect('/users/login');
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

router.get('/rateTransaction', function(req, res) {
    var Transaction = Parse.Object.extend("Transaction");
    var query = new Parse.Query(Transaction);
    query.get(req.query.transaction, {
        success: function(result) {
            //Check current user against buyer (in transaction)
            //Make sure transaction hasn't already been reviewed
            //If both pass, take them to the rate transaction page
        },
        error: function(object, error) {
            res.render('pages/error_try_again');
        }
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
        // The login failed. Check error to see why.
        res.render('pages/users/login_error', {error:error});
      }
    });
});

router.get('/signup', function(req, res) {
    res.render('pages/users/signup');
});

router.post('/signup/submit', function(req, res) {
    var user = new Parse.User();
    user.set("username", req.body.username);
    user.set("password", req.body.password);
    user.set("email", req.body.email);
    user.set("credits", 50);

    user.signUp(null, {
      success: function(user) {
        // Hooray! Let them use the app now.
        req.session.token = user.getSessionToken();
        res.send("Created account successfully");
      },
      error: function(user, error) {
        // Show the error message somewhere and let the user try again.
        res.send("Error: " + error.code + " " + error.message);
      }
    });
});

router.get('/myprofile', function(req, res) {
    checkLogin(req, res).then(function(res) {
        console.log(res.locals.user);
        res.render('pages/users/profile', {user: res.locals.user});
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
