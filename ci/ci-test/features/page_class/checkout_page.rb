require_relative './base_page'

class CheckoutPage < BasePage

  text_field(:name, name: 'name')
  text_field(:address, name: 'address')
  text_field(:name_on_the_card, id: 'card-name')
  text_field(:card_number, id: 'card-number')
  text_field(:expiry_month, id: 'card-expiry-month')
  text_field(:expiry_year, id: 'card-expiry-year')
  text_field(:cvv, id: 'card-cvc')
  button(:buy_now, text: 'Buy now')
end