var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('shopping/index', { title: 'Book Store Application' });
});

module.exports = router;
