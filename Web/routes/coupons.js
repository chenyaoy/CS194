var express = require('express');
var Parse = require('parse/node');
Parse.initialize("codeconomy");
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';

var bodyParser = require('body-parser');

var router = express.Router();
router.use(bodyParser.json()); // support json encoded bodies
router.use(bodyParser.urlencoded({ extended: true }));

router.get('/', function(req, res) {
    res.render('pages/index',{balance:50});
});

router.get('/postCoupon', function(req, res) {
    res.render('pages/post_coupon',{balance:50});
});

router.post('/postCoupon/submit', function(req, res) {
    if(validateRequiredCouponParams(req)) {
        var Coupon = Parse.Object.extend("Coupon");
        var coupon = new Coupon();
    	coupon.set("storeName", req.body.store);
    	coupon.set("description", req.body.couponDescription);
    	coupon.set("expirationDate", 
            typeof(req.body.expireDate) == undefined ? null : req.body.expireDate);
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

function validateRequiredCouponParams(req) {
    if(typeof(req.body.store) == 'undefined') {
        console.log(1);
        return false;
    }
    if(typeof(req.body.couponDescription) == 'undefined') {
        console.log(2);
        return false;
    }
    if(req.body.expireBool && typeof(req.body.expireDate) == 'undefined') {
        console.log(3);
        return false;
    }
    if(typeof(req.body.price) == undefined || req.body.price < 0) {
        console.log(4);
        return false;
    }
    if(typeof(req.body.code) == undefined) {
        console.log(5);
        return false;
    }
    return true;
}

module.exports = router;