Given(/^I open homepage$/) do
  @browser.goto(ENV['ENDPOINT'])
end

When(/^I click on "([^"]*)" button$/) do |arg|
  @home_page.open_signup_page
end

And(/^I fill the user details$/) do

end

And(/^I set the (\d+) length long password for the account$/) do |arg|

end

Then(/^I land on the "([^"]*)" page$/) do |arg|

end

And(/^I fill the user details for "([^"]*)" customer$/) do |arg|

end

Then(/^I should see the error message "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|

end