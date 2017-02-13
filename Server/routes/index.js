var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
    res.send(__dirname);
});


module.exports = router;
