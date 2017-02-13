var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
    res.send(path.join(__dirname, '/'));
});


module.exports = router;
