var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var Parse = require('parse/node').Parse;
var routes = require('./routes/index');
var recording = require('./routes/recording');

/* multer for uploading multi-media */
var multer  = require('multer');
var upload = multer({ dest: 'uploads/' });

var app = express();

// // view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// // uncomment after placing your favicon in /public
// app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

Parse.initialize("8Nx1MZhNZzI6jw1SM73isCHpmGGIPBvx0OQTJJl3","jU9dbSvBPVQLHD9saDx4PU7FNvqUkxZLCYFgLLpq");
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


app.use('/', routes);
app.use('/recording', recording);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
