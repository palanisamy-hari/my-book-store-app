let passport = require('passport');
let User = require('../models/user');
let LocalStrategy = require('passport-local').Strategy;

// store user in session - serialize it by ID
passport.serializeUser(function (user, done) {
    done(null, user.id);
});

passport.deserializeUser(function (id, done) {
    User.findById(id, function (err, user) {
        done(err, user);
    });
});

// Passport sign up strategy: 
passport.use('local.signup', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, function (req, email, password, done) {
    // validate passed parameters
    req.checkBody('email', 'Invalid E-mail').notEmpty().isEmail();
    req.checkBody('password', 'Invalid Password - Minimum lenght is 4').notEmpty().isLength({ min: 4 });
    let errors = req.validationErrors();
    if (errors) {
        let messages = [];
        errors.forEach(function (error) {
            messages.push(error.msg);
        });
        return done(null, false, req.flash('error', messages));
    }
    User.findOne({ 'email': email }, function (err, user) {
        if (err) {
            return done(err);
        }
        if (user) {
            // Email already exists 
            return done(null, false, { message: 'Email is already in use. ' });
        }
        let newUser = new User();
        newUser.email = email;
        newUser.password = newUser.encryptPassword(password);
        newUser.save(function (err, result) {
            if (err) {
                return done(err);
            }
            return done(null, newUser);
        });
    });
}));

passport.use('local-signin', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, function (req, email, password, done) {
    req.checkBody('email', 'Invalid E-mail').notEmpty().isEmail();
    req.checkBody('password', 'Invalid Password - Minimum lenght is 4').notEmpty();
    let errors = req.validationErrors();
    if (errors) {
        let messages = [];
        errors.forEach(function (error) {
            messages.push(error.msg);
        });
        return done(null, false, req.flash('error', messages));
    }
    User.findOne({ 'email': email }, function (err, user) {
        if (err) {
            return done(err);
        }
        if (!user) {
            // Email already exists 
            return done(null, false, { message: 'No User found.' });
        }
        if (!user.validPassword(password)) {
            return done(null, false, { message: 'Wrong Password' });
        }
        return done(null, user);
    });
}));