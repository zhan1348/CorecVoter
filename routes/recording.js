var express = require('express');
var router = express.Router();
var Parse = require('parse/node').Parse;




Parse.initialize("8Nx1MZhNZzI6jw1SM73isCHpmGGIPBvx0OQTJJl3","jU9dbSvBPVQLHD9saDx4PU7FNvqUkxZLCYFgLLpq");

/* GET users listing. */
router.get('/', function(req, res, next) {
  console.log(req);
  res.send('respond with a resource');
});

router.get('/list/:user_id', function(req, res, next) {
  console.log(req.params.user_id);

  var Recording = Parse.Object.extend("RecordingObject");
  var query = new Parse.Query(Recording);
  query.equalTo("UserID", req.params.user_id);
  query.find({
    success: function(results) {
      console.log("Successfully retrieved " + results.length);
      // Do something with the returned Parse.Object values
      for (var i = 0; i < results.length; i++) {
        var object = results[i];
        console.log(object.id + ' - ' + object.get('column'));
      }
      console.log("Successfully retrieved " + results.length );
      res.send(results);

    },
    error: function(error) {
      console.error("Error: " + error.code + " " + error.message);
      res.status('404');
      res.send('error');

    }
  });
  // res.send('respond with a resource');
});

router.post('/delete', function(req, res){
  console.log(req.body.recordingID);
  var recordingID = req.body.recordingID;
  var Recording = Parse.Object.extend("RecordingObject");
  var query = new Parse.Query(Recording);
  query.equalTo("objectId", recordingID);
  query.get( {
    success: function(myObj) {
      // The object was retrieved successfully.
      myObj.destroy({});
      console.log('destroying object');
      res.status(200);
      res.send("OK");

    },
    error: function(object, error) {
      // The object was not retrieved successfully.
      // error is a Parse.Error with an error code and description.
      res.status(403);
      res.send("error");
    }
  });
});

router.post('/upload', function(req, res) {
  console.log(req);
  res.send('OK');
});

router.post('/newrecord', function(req,res){
  var title = req.body.title
  var description = req.body.description;
  var userID = req.body.userID;

  var latitude = req.body.latitude;
  var longitude = req.body.longitude;

  console.log(req.body);
  console.log('title:' + title + ', description:' + description+', userID:' +userID + ', latitude:' + latitude + ', longitude:'+longitude);
  var RecordingObject = Parse.Object.extend("RecordingObject");
  var recordingObject = new RecordingObject();
  console.log("here !");
  // , Longitutde: longitude, Latitude: latitude
  var point = new Parse.GeoPoint({latitude: latitude, longitude: longitude});
  recordingObject.set("location", point);
  recordingObject.save({RecordingTitle: title,RecordingDescription: description, UserID:userID}, {
    success: function(Object) {
        console.log("success!!!");
        res.status(200);
        res.send("sucess");
    },
    error : function(obj, error) {
      console.log(error);
      res.status(403);
      res.send("failed");
    }
  });
  // res.send('OK');
});

/* Get listing recordings */
router.get('/list', function(req,res, next) {
  console.log('here');
  // res.send(apple = appl, orange = org, charles, crls);
  var userLongitude = parseFloat(req.query.longitude);
  console.log(userLongitude);
  var userLatitude =  parseFloat(req.query.latitude);
  console.log('Longitude: ' + userLongitude + ',Latitude: '+ userLatitude);
  var point = new Parse.GeoPoint({latitude: userLatitude, longitude: userLongitude});

  var Recording = Parse.Object.extend("RecordingObject");
  var query = new Parse.Query(Recording);

  query.near("location", point);
  query.withinMiles("location", point, 20);
  query.find({
    success: function(results) {
      console.log("Successfully retrieved " + results.length);
      // Do something with the returned Parse.Object values
      for (var i = 0; i < results.length; i++) {
        var object = results[i];
        console.log(object.id + ' - ' + object.get('column'));
      }
      console.log("Successfully retrieved " + results.length );
      res.send(results);

    },
    error: function(error) {
      console.error("Error: " + error.code + " " + error.message);
      res.status('404');
      res.send('error');

    }
  });
  // res.json([{a:1222}, {a:233333}, {a:34444}]);
});

router.get('/send', function(req,res, next) {
  //
  var RecordingObject = Parse.Object.extend("RecordingObject");
  var recordingObject = new RecordingObject();
  console.log("here !");
  recordingObject.save({foo: "bar"}, {
    success: function(Object) {
        console.log("success!!!");
    },
    error : function(obj, error) {
      console.log(error);
    }
  });
  res.json([{a:1222}, {a:233333}, {a:34444}]);
});

/* method handling post request*/
// router.get('/post', function(req,res, next,post){
//
// });


module.exports = router;
