var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

/* Get listing recordings */
router.get('/list', function(req,res, next) {
  // res.send(apple = appl, orange = org, charles, crls);
  res.json([{a:1222}, {a:233333}, {a:34444}]);
});


module.exports = router;
