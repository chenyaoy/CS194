var express = require('express');
var Parse = require('parse');
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';

var router = express.Router();

router.get('/', function(req, res) {
    res.render('pages/index',{balance:50});
});

router.get('/postCoupon', function(req, res) {
    res.render('pages/post_coupon',{balance:50});
});

router.post('/postCoupon/submit', function(req, res) {
	var Coupon = Parse.Object.extend("Coupon");
	var coupon = new Coupon();
	coupon.set("storeName", req.couponStoreName);
	coupon.set("description", req.couponDescription);
	coupon.set("expirationDate", req.couponExpDate);
	coupon.set("additionalInfo", req.additionalCouponInfo);
	coupon.set("price", req.couponPrice);
	coupon.set("code", req.couponCode);
	coupon.set("category", req.couponCategory);
    coupon.set("status", "unsold");
    coupon.set("deleted", false);
    
	coupon.save(null, {
  		success: function(coupon) {
    		res.send("Coupon uploaded successfully.");
  		},
  		error: function(coupon, error) {
    		res.send("Coupon upload failed. Please try again.")
        }
    });
});

module.exports = router;