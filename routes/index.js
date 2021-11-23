let express = require('express');
let router = express.Router();
var Cart = require('../models/cart');
let Books = require('../models/books');

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('shopping/index', {title: 'Book Store Application'});
});

router.get('/health', function (req, res, next) {
    res.render('shopping/base', {title: "Application is healthy!!"});
});

router.get('/live', function (req, res, next) {
    res.render('shopping/base', {title: "Application is live!!"});
});


router.get('/books', function (req, res, next) {
    let books = Books.find(function (err, docs) {
        let successMsg = req.flash('success')[0];
        let bookArray = [];
        let chunkSize = 3;
        for (let i = 0; i < docs.length; i += chunkSize) {
            bookArray.push(docs.slice(i, i + chunkSize))
        }
        res.render('shopping/books', {
            title: 'Buy Books | Welcome',
            books: bookArray,
            successMsg: successMsg,
            noMessages: !successMsg
        });
    }).lean();
});

router.get('/add-to-cart/:id', function(req, res, next) {
    var BookId = req.params.id;
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    Books.findById(BookId, function(err, product){
        if(err){
            return res.redirect('/');
        }
        cart.add(product, product.id);
        req.session.cart = cart;
        res.redirect('/books');
    });
});

router.get('/shopping-cart', function(req, res, next) {
    if(!req.session.cart){
        return res.render('shopping/shopping-cart', {products: null});
    }
    var cart = new Cart(req.session.cart);
    res.render('shopping/shopping-cart', {products: cart.generateArray(), totalPrice: cart.totalPrice});
});

router.get('/reduce/:id', function(req, res, next) {
    var BookId = req.params.id;
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    cart.reduceByOne(BookId);
    req.session.cart = cart;
    res.redirect('/shopping-cart');
});

router.get('/remove/:id', function(req, res, next) {
    var BookId = req.params.id;
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    cart.removeItem(BookId);
    req.session.cart = cart;
    res.redirect('/shopping-cart');
});

router.post('/checkout', isLoggedIn, function(req, res, next) {
    if(!req.session.cart){
        return res.render('shop/shopping-cart', {products: null});
    }
});

function isLoggedIn(req, res, next){
    if(req.isAuthenticated()) {
        return next();
    }
    req.session.oldUrl = req.url;
    res.redirect('/user/signin');
}

module.exports = router;
