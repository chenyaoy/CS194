var express = require('express');

var router = express.Router();

router.get('/', function(req, res) {
    res.render('pages/index',{balance:50});
});

router.post('/', function(req, res) {
    res.send('POST handler for /coupons route.');
});

module.exports = router;