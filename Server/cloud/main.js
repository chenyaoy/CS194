
Parse.Cloud.define('hello', function(req, res) {
  res.success('Hi');
});

Parse.Cloud.define("addCredits", function(request, response) {
	Parse.Cloud.useMasterKey();
	var objectId = request.params.objectId;
	var credits = request.params.credits;
	var query = new Parse.Query(Parse.User);
	query.equalTo("objectId", objectId);
	query.include("credits");
	query.first({
	    success: function(userRecord) {
	    	userRecord.fetch();
			userRecord.set("credits", userRecord.get("credits") + credits);
			userRecord.save(null, {
                success: function(user) {
                    console.log('save user success');
                    response.success("save user success")
                    userRecord.fetch();
                },
                error: function(error) {
                    console.log("failed to save user");
                    response.error(error);
                }
            });
	    },
	    error: function(error) {
	      response.error("add credits failed");
	    }
	});
});