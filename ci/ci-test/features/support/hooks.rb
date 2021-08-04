Before do |scenario|
  puts scenario.name
  @browser = BrowserUtilities.launch_browser(ENV['BROWSER'])
  BrowserUtilities.resize_browser
end

Before do
  @base_page          = BasePage.new @browser
  @login_page         = LoginPage.new @browser
  @my_activities_page = BooksPage.new @browser
  @home_page          = HomePage.new @browser
end

After do |scenario|
  puts "Scenario Passed?: #{ scenario.passed?}"
  @browser.close
end
