require_relative './base_page'

class CartPage < BasePage

  link(:checkout, href: '/checkout')
end