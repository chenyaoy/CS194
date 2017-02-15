var express = require('express');
var Parse = require('parse/node');
Parse.initialize("codeconomy");
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';

var bodyParser = require('body-parser');

var router = express.Router();
router.use(bodyParser.json()); // support json encoded bodies
router.use(bodyParser.urlencoded({ extended: true }));

router.post('/postCoupon/submit', function(req, res) {
    if(validateRequiredCouponParams(req)) {
        var Coupon = Parse.Object.extend("Coupon");
        var coupon = new Coupon();
        coupon.set("storeName", req.body.store);
        coupon.set("description", req.body.couponDescription);
        coupon.set("expirationDate", new Date());
        coupon.set("expirationDate", 
            typeof(req.body.expireDate) == undefined ? null : new Date(req.body.expireDate));
        coupon.set("additionalInfo", 
            typeof(req.body.additionalInfo) == undefined ? "" : req.body.additionalInfo);
        coupon.set("price", req.body.price);
        coupon.set("code", req.body.code);
        coupon.set("category", req.body.category);
        coupon.set("status", "unsold");
        coupon.set("deleted", false);
        coupon.save(null, {
            success: function(coupon) {
                res.send("Coupon uploaded successfully.");
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

router.get('/myCoupons/purchased', function(req, res) {
    res.render('pages/index',{balance:50});
});

router.get('/myCoupons/sold', function(req, res) {
    res.render('pages/index',{balance:50});
});

router.get('/myCoupons', function(req, res) {
    res.render('pages/index',{balance:50});
});

router.get('/coupon', function(req, res) {

    res.render('pages/coupon_page',{balance:50});
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

router.get('/', function(req, res) {
    query = unsoldQuery();
    serveQuery(query, res, "All");
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
        return false;
    }
    if(typeof(req.body.couponDescription) == 'undefined') {
        return false;
    }
    if(req.body.expireBool && typeof(req.body.expireDate) == 'undefined') {
        return false;
    }
    if(typeof(req.body.price) == undefined || req.body.price < 0) {
        return false;
    }
    if(typeof(req.body.code) == undefined) {
        return false;
    }
    return true;
}

module.exports = router;