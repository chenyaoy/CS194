var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
    res.send(path.join(__dirname, '../views/hello_world.html'));
});


module.exports = router;
