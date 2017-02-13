var express = require('express');
var coupons = require('./routes/coupons');
var users = require('./routes/users');

var app = express();

app.set('port', (process.env.PORT || 5000));

app.use('/coupons',  coupons);
app.use('/users', users);
app.use(express.static(__dirname + '/public'));

// views is directory for all template files
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.get('/', function(req, res) {
  res.render('pages/index', {balance:50});
});

app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});


