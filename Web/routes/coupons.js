var express = require('express');
var Parse = require('parse/node');
Parse.initialize("codeconomy");
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';
Parse.User.enableRevocableSession();

var bodyParser = require('body-parser');

var router = express.Router();
router.use(bodyParser.json()); // support json encoded bodies
router.use(bodyParser.urlencoded({ extended: true }));

router.post('/postCoupon/submit', function(req, res) {
    if(req.session.token) {
        var sq = new Parse.Query('_Session')
                          .equalTo('sessionToken', req.session.token)
                          .include('user');
        sq.first().then(function(sessionResult) {
            if (!sessionResult) {
                res.send("No matching session");
            } else {
                req.user = sessionResult.get('user');
                res.locals.session = req.session;
                res.locals.user = req.user;
            }
        }, function(err) {
            debug("Error or no matching session: " + err);
            res.redirect('/account/pub/login');
        });
    } else {
        //redirect to user
        res.send("User not logged in");
    }
    console.log(req.user);
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
        coupon.set("status", 1);
        coupon.set("deleted", false);
        coupon.set("sellerId", user.objectId);
        coupon.save(null, {
            success: function(coupon) {
                var query = new Parse.Query(Coupon);
                query.equalTo("sellerId", user.objectId);
                query.find({
                    success: function(userCoupons) {
                        res.send(userCoupons);
                    }
                });
                // res.send("Coupon uploaded successfully.");
            },
            error: function(coupon, error) {
                res.send("Coupon upload failed. Please try again. " + error.message)
            }
        });
    } else {
        res.send("Error in provided coupon data. Please verify that all information was entered correctly.")
    }
});

router.get('/postCoupon', function(req, res) {
    res.render('pages/post_coupon',{balance:50});
});


router.get('/purchaseCoupon', function(req, res) {
     res.render('pages/error_try_again',{balance:50});
});

router.get('/coupon', function(req, res) {
    var Coupon = Parse.Object.extend("Coupon");
    var query = new Parse.Query(Coupon);
    query.get(req.query.id, {
        success: function(result) {
            var coupon = {};
            coupon.storeName = result.get('storeName');
            coupon.description = result.get('description');
            coupon.price = result.get('price');
            coupon.category = result.get('category');
            coupon.additionalInfo = result.get('additionalInfo');
            coupon.id = req.query.id;
            if(result.has('expirationDate')) {
                coupon.expirationDate = result.get('expirationDate');
            }
            res.render('pages/display_coupon', {balance:50, coupon:coupon});
        },
        error: function(object, error) {
            res.render('pages/error_try_again');
        }
    });
});

router.get('/clothing', function(req, res) {
    query = unsoldQuery();
    query.equalTo("category", "Clothing")
    serveQuery(query, res, "Clothing");
});

router.get('/electronics', function(req, res) {
    query = unsoldQuery();
    query.equalTo("category", "Electronics")
    serveQuery(query, res, "Electronics");
});

router.get('/concerts', function(req, res) {
    query = unsoldQuery();
    query.equalTo("category", "Concerts")
    serveQuery(query, res, "Concerts");
});

router.get('/food', function(req, res) {
    query = unsoldQuery();
    query.equalTo("category", "Food")
    serveQuery(query, res, "Food");
});

router.get('/explore', function(req, res) {
    query = unsoldQuery();
    serveQuery(query, res, "All");
});

router.get('/', function(req, res) {
    res.render('pages/coupon_home',{balance:50});
});

function unsoldQuery() {
    var Coupon = Parse.Object.extend("Coupon");
    var query = new Parse.Query(Coupon);
    query.equalTo("status", "unsold");
    query.equalTo("deleted", false);
    return query;
}

function serveQuery(query, res, category) {
    query.find({
        success: function(results) {
            var coupons = [];
            for(var i = 0; i < results.length; i++) {
                var coupon = {};
                coupon.storeName = results[i].get('storeName');
                coupon.description = results[i].get('description');
                coupon.price = results[i].get('price');
                coupon.category = results[i].get('category');
                coupon.id = results[i].id;
                coupons.push(coupon);
            }
            res.render('pages/explore_coupons', {coupons:coupons, balance:50, category:category});
        },
        error: function(error) {
            res.render('pages/error_try_again');
        }
    });
}

function validateRequiredCouponParams(req) {
    if(typeof(req.body.store) == 'undefined') {
        console.log(1);
        return false;
    }
    if(typeof(req.body.couponDescription) == 'undefined') {
        console.log(2);
        return false;
    }
    if(req.body.expireBool == 'Yes' && req.body.expireDate.length == 0) {
        console.log(3);
        return false;
    }
    if(typeof(req.body.price) == 'undefined' || req.body.price < 0) {
        console.log(4);
        return false;
    }
    if(typeof(req.body.code) == 'undefined') {
        console.log(5);
        return false;
    }
    return true;
}

module.exports = router;
