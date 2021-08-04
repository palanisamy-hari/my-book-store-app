################# Overview ####################
#Defines methods to handle launching different#
#types of browsers as well as logging out and #
#closing the browser. Also defines methods for#
#sorting through scenario tags.               #
###############################################

class BrowserUtilities

  attr_accessor :browser

  def self.launch_browser(browser_type = 'chrome', remote = false, headless = false)

    p "browser-type: #{browser_type}"
    p "remote: #{remote}"
    p "headless: true #{headless}" if browser_type == 'chrome_headless' || headless

    prefs = {
      'download' => {
        'prompt_for_download' => false,
        'directory_directory' => false
      },
      'profile' => {
        'default_content_setting_values' => { 'automatic_downloads' => 1 }
      }
    }

    @browser = case browser_type.downcase
               when 'chrome'
                 chrome_driver_path = "#{File.dirname(__FILE__)}/../driver/chromedriver.exe"
                 Selenium::WebDriver::Chrome::Service.driver_path = chrome_driver_path
                 Watir::Browser.new(:chrome, headless: false, options: browser_opts)
               when 'chrome_headless'
                 Watir::Browser.new(:chrome, headless: true, options: browser_opts)
               when 'chrome_remote'
                 Watir::Browser.new :chrome, url: "http://localhost:4444/wd/hub" , options: {prefs: prefs, options: { 'useAutomationExtension' => false } }
               when 'firefox_remote'
                 Watir::Browser.new(:firefox, options: browser_opts, url: 'http://localhost:4444/wd/hub')
               when 'firefox'
                 firefox_driver_path = "#{File.dirname(__FILE__)}/../driver/geckodriver.exe"
                 Selenium::WebDriver::Firefox::Service.driver_path = firefox_driver_path
                 Watir::Browser.new(:firefox, headless: false, options: browser_opts)
               when 'firefox_headless'
                 Watir::Browser.new(:firefox, headless: true, options: browser_opts)
               else
                 raise "Browser type not found features/support/helpers/browser_utilities.rb:#{__LINE__}"
               end
  end

  # resizing browser even after --start-maximized flag in browser options; This is specially for remote browsers
  def self.resize_browser
    screen_width = @browser.execute_script('return screen.width;')
    screen_height = @browser.execute_script('return screen.height;') - 50

    width, height = ENV['width'].nil? \
                      ? [screen_width, screen_height] \
                      : [ENV['width'], ENV['height']]

    @browser.window.move_to(0, 0)
    @browser.window.resize_to(width, height)
  end
end
