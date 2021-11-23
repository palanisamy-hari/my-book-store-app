Before do |scenario|
  @sleep_duration = 2
  @log = Logger.new(STDOUT)
  @log.info("Scenario name: #{scenario.name}")
  @browser = BrowserUtilities.launch_browser(ENV['BROWSER'])
  BrowserUtilities.resize_browser
end

Before do
  @base_page          = BasePage.new @browser
  @login_page         = LoginPage.new @browser
  @my_activities_page = BooksPage.new @browser
  @home_page          = HomePage.new @browser
  @signup_page        = SignupPage.new @browser
end

After do |scenario|
  @log.info("Scenario Passed?: #{ scenario.passed?}")
  @browser.close
end
