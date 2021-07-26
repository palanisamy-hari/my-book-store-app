let createError = require('http-errors');
let express = require('express');
let path = require('path');
let cookieParser = require('cookie-parser');
let expressHbs = require('express-handlebars');
let logger = require('morgan');
let mongoose = require('mongoose');
let indexRouter = require('./routes/index');
let userRouter = require('./routes/user');
let session = require('express-session');
let passport = require('passport');
let flash = require('connect-flash');
let validator = require('express-validator');
let app = express();
require('dotenv').config({ path: './.env' });
let MongoStore = require('connect-mongo');

require('./config/passport');

// const PORT = process.env.PORT || 9000;
const MONGODB_URI = 'mongodb+srv://mongo_user:gC2IfDEuQedHq0Vj@cluster0.eagru.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
const OPTS = { useNewUrlParser: true, useUnifiedTopology: true };
mongoose.connect(MONGODB_URI, OPTS, function (err) {
  if (err) { return console.log(err); }
});

// view engine setup
app.engine('.hbs', expressHbs({ defaultLayout: 'layout', extname: '.hbs'}));
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: 'mysupersecret',
  resave: false,
  saveUninitialized: false,
  store: MongoStore.create({
    mongoUrl: MONGODB_URI
  }),
  cookie: { maxAge: 180 * 60 * 1000 }
}));

app.use(flash());
app.use(validator());

// Passport Authentication
app.use(passport.initialize());
app.use(passport.session());
app.use(express.static(path.join(__dirname, 'public')));

// Custom middleware to pass authentication state and session to views
app.use(function (req, res, next) {
  res.locals.signin = req.isAuthenticated();
  res.locals.session = req.session;
  next();
});

app.use('/', indexRouter);
app.use('/user', userRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});


module.exports = app;
// app.listen(PORT);
// console.log('Started BookStore application on port ' + PORT);