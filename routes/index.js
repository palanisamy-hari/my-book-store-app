let express = require('express');
let router = express.Router();
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

module.exports = router;
