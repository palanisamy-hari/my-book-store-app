require_relative './base_page'

class BooksPage < BasePage
  link(:first_book, text: 'Add to Cart', index: 0)
  link(:second_book, text: 'Add to Cart', index: 1)
  link(:third_book, text: 'Add to Cart', index: 2)


  link(:cart, text: /Cart/)


end