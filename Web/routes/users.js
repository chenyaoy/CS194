var express = require('express');
var Parse = require('parse/node');
Parse.initialize("codeconomy");
Parse.serverURL = 'http://codeconomy.herokuapp.com/parse';
Parse.masterKey = 'flatstanley';

var bodyParser = require('body-parser');

var router = express.Router();
router.use(bodyParser.json()); // support json encoded bodies
router.use(bodyParser.urlencoded({ extended: true }));

router.get('/myCoupons/purchased', function(req, res) {
    res.render('pages/error_try_again',{balance:50});
});

router.get('/myCoupons/sold', function(req, res) {
    res.render('pages/error_try_again',{balance:50});
});

router.get('/myCoupons', function(req, res) {
    var currentUser = Parse.User.current();
    if (currentUser) {
        var Coupon = Parse.Object.extend("Coupon");
        var query = new Parse.Query(Coupon);
        query.equalTo("sellerId", currentUser.objectId);
        query.equalTo("deleted", false);
        serveQuery(query, res, "All");
    } else {
        res.send("Error: Not logged in");
    }
});

router.get('/rateTransaction', function(req, res) {
    var Transaction = Parse.Object.extend("Transaction");
    var query = new Parse.Query(Transaction);
    query.get(req.query.transaction, {
        success: function(result) {
            //Check current user against buyer (in transaction)
            //Make sure transaction hasn't already been reviewed
            //If both pass, take them to the rate transaction page
        },
        error: function(object, error) {
            res.render('pages/error_try_again');
        }
    });
});

router.get('/', function(req, res) {
    res.render('pages/index');
});

router.post('/', function(req, res) {
    res.send('POST handler for /users route.');
});

router.get('/login', function(req, res) {
    res.render('pages/users/login',{balance:50});
});

router.post('/login/submit', function(req, res) {
    Parse.User.logIn(req.body.username, req.body.password, {
      success: function(user) {
        req.session.token = user.getSessionToken();
        res.send("Logged in successfully");
      },
      error: function(user, error) {
        // The login failed. Check error to see why.
        res.send("Error: " + error.code + " " + error.message);
      }
    });
});

router.get('/signup', function(req, res) {
    res.render('pages/users/signup',{balance:50});
});

router.post('/signup/submit', function(req, res) {
    var user = new Parse.User();
    user.set("username", req.body.username);
    user.set("password", req.body.password);
    user.set("email", req.body.email);

    user.signUp(null, {
      success: function(user) {
        // Hooray! Let them use the app now.
        req.session.token = user.getSessionToken();
        res.send("Created account successfully");
      },
      error: function(user, error) {
        // Show the error message somewhere and let the user try again.
        res.send("Error: " + error.code + " " + error.message);
      }
    });
});


router.post('/logout', function(req, res) {
  req.session.token = null;
});

module.exports = router;
