// To seed Data Run "node .\book-seeder.js" in terminal

let Book = require('../models/books');
let mongoose = require('mongoose')


const MONGODB_URL = 'mongodb+srv://mongo_user:gC2IfDEuQedHq0Vj@cluster0.eagru.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
const OPTS = { useNewUrlParser: true, useUnifiedTopology: true };
mongoose.connect(MONGODB_URL, OPTS, function (err) {
    if (err) { return console.log(err); }
});
let books = [
    new Book({
        imagePath: 'https://upload.wikimedia.org/wikipedia/commons/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg',
        title: 'To Kill a Mockingbird',
        Author: 'Harper Lee',
        description: 'To Kill a Mockingbird is a novel by the American author Harper Lee. It was published in 1960 and was instantly successful.',
        price: 10
    }), new Book(
        {
            imagePath: 'https://images-na.ssl-images-amazon.com/images/I/81djg0KWthS.jpg',
            title: 'The Great Gatsby',
            Author: 'F. Scott Fitzgerald',
            description: 'The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway\'s interactions with mysterious millionaire Jay Gatsby and Gatsby\'s obsession to reunite with his former lover, Daisy Buchanan.',
            price: 20
        }), new Book(
        {
            imagePath: 'https://upload.wikimedia.org/wikipedia/en/thumb/6/6b/Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg/220px-Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg',
            title: 'Harry Potter and the Philosopher\'s Stone',
            Author: 'J. K. Rowling',
            description: 'Harry Potter and the Philosopher\'s Stone is a fantasy novel written by British author J. K. Rowling. The first novel in the Harry Potter series and Rowling\'s debut novel.',
            price: 20
        })]

let done = 0;
for (let i = 0; i < books.length; i++) {
    books[i].save(function (err, result) {
        done++;
        if (done === books.length) {
            exit();
        }
    });
}
function exit() {
    mongoose.disconnect();
}