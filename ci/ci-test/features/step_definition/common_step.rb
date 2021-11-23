Given(/^I open homepage$/) do
  @browser.goto(ENV['ENDPOINT'])
end

When(/^I click on "([^"]*)" button on signup page$/) do |button_name|
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
  @home_page.open_signup_page
end

And(/^I click on "([^"]*)" button on home page$/) do |button_name|
  sleep @sleep_duration
  @home_page.send("#{button_name}_element").click
end

And(/^I click on "([^"]*)" button on sign page$/) do |button_name|
  sleep @sleep_duration
  @login_page.send("#{button_name}_element").click
end