Given(/^I open homepage$/) do
  @browser.goto(ENV['ENDPOINT'])
end

When(/^I click on "([^"]*)" on signup page$/) do |button_name|
  sleep @sleep_duration
  @signup_page.send("#{button_name}_element").click
end

And(/^I fill the user details$/) do
  sleep @sleep_duration
  @signup_page.sign_up_email = Faker::Internet.email(domain: 'gmail')
end

And(/^I set the "([^"]*)" length long password for the account$/) do |password_length|
  sleep @sleep_duration
  @signup_page.sign_up_password = Faker::Internet.password(min_length: password_length.to_i, max_length: password_length.to_i)
end

Then(/^I land on the "([^"]*)" page$/) do |expected_text|
  sleep @sleep_duration
  expect(@home_page.user_profile).to include(expected_text)
end

And(/^I fill the user details for "([^"]*)" customer$/) do |arg|
  sleep @sleep_duration
  @login_page.sign_in_email = 'test123@gmail.com'
  @login_page.sign_in_password = '12345678'
end

Then(/^I should see the error message "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|

end

When(/^I click on sign up link$/) do
  sleep @sleep_duration
  @home_page.sign_up_element.click
end

And(/^I click on "([^"]*)" button on home page$/) do |button_name|
  sleep @sleep_duration
  @home_page.send("#{button_name}_element").click
end

And(/^I click on "([^"]*)" button on sign page$/) do |button_name|
  sleep @sleep_duration
  @login_page.send("#{button_name}_element").click
end

And(/^I open the books page$/) do
  sleep @sleep_duration
  @home_page.books_link_element.click
  @home_page.books_link_element.click
end

And(/^I add "([^"]*)" books to the cart$/) do |number_of_books|
  sleep @sleep_duration
  @books_page.first_book_element.click
  sleep @sleep_duration
  @books_page.second_book_element.click
  sleep @sleep_duration
end

And(/^I go to cart page$/) do
  sleep @sleep_duration
  @books_page.cart_element.click
end

And(/^I click checkout$/) do
  sleep @sleep_duration
  @cart_page.checkout_element.click
end

And(/^I enter payment information$/) do
  @checkout_page.name = 'Hari'
  @checkout_page.address = '123 Main st'
  @checkout_page.name_on_the_card = 'Hari'
  @checkout_page.card_number = '378282246310005'
  @checkout_page.expiry_month = '08'
  @checkout_page.expiry_year = '2022'
  @checkout_page.cvv = '266'
  sleep @sleep_duration
end

And(/^I click buy now$/) do
  sleep @sleep_duration
  @checkout_page.buy_now_element.click
end