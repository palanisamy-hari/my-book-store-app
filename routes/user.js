let express = require('express');
let router = express.Router();


let csrf = require('csurf');
const passport = require('passport');
let Order = require('../models/order');
let Cart = require('../models/cart');

let csrfProtection = csrf();
router.use(csrfProtection);

router.get('/profile', isLoggedIn, function (req, res, next) {
  Order.find({ user: req.user }, function (err, orders) {
    if (err) {
      return res.write('Error!');
    }
    var cart;
    orders.forEach(function (order) {
      cart = new Cart(order.cart);
      order.items = cart.generateArray();
    });
    res.render('user/profile', { orders: orders, title: 'Buy Books | User Profile' });
  });
});

router.get('/logout', isLoggedIn, function (req, res, next) {
  req.logout();
  res.redirect('/');
});
router.use('/', notLoggedIn, function (req, res, next) {
  next();
});

router.get('/signup', function (req, res, next) {
  // error messages are stored in 'error'
  var messages = req.flash('error');
  // Pass token to View
  res.render('user/signup', { csrfToken: req.csrfToken(), messages: messages, hasErrors: messages.length > 0, title: 'Buy Books | Sign Up Page' });
});
// Argument is the strategy created in passport.js file:
router.post('/signup', passport.authenticate('local.signup', {
  successRedirect: '/user/profile',
  failureRedirect: '/user/signup',
  failureFlash: true
}));

router.get('/signin', function (req, res, next) {
  var messages = req.flash('error');
  res.render('user/signin', { csrfToken: req.csrfToken(), messages: messages, hasErrors: messages.length > 0, title: 'Buy Books | Sign In Page' });
});


router.post('/signin', passport.authenticate('local-signin', {
  successRedirect: '/user/profile',
  failureRedirect: '/user/signup',
  failureFlash: true
}));

module.exports = router;


function isLoggedIn(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/');
}

function notLoggedIn(req, res, next) {
  if (!req.isAuthenticated()) {
    return next();
  }
  res.redirect('/');
}