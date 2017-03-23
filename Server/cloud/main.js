
Parse.Cloud.define('hello', function(req, res) {
  res.success('Hi');
});

Parse.Cloud.define("addCredits", function(request, response) {
	var username = request.params.username;
	var credits = request.params.credits;
	var query = new Parse.Query(Parse.User);
	query.equalTo("username", username);
	query.find({
	    success: function(user) {
			user.set("credits", user.get("credits") + credits);
			user.save(null, {
                success: function(user) {
                    console.log('save user success');
                    response.success("save user success")
                },
                error: function(user, error) {
                    console.log("failed to save user");
                    response.error("failed to save user")
                }
            });
	    },
	    error: function(object, error) {
	      response.error("add credits failed");
	    }
	});
});