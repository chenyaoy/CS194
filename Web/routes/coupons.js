var express = require('express');

var router = express.Router();

router.get('/', function(req, res) {
    res.render('pages/index');
});

router.post('/', function(req, res) {
    res.send('POST handler for /coupons route.');
});

module.exports = router;