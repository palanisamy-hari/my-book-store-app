require_relative './base_page'

class HomePage < BasePage

  link(:signup_link, href: '/user/signup')
  link(:signin_link, href: '/user/signin')

  def open_signup_page
    self.signup_link_element.click
    wait_for_element('signup_page')
    expect(self.signup_page).to eq('Sign Up')
  end

  def open_signin_page
    self.signin_link_element.click
    wait_for_element('signin_page')
    expect(self.signin_page).to eq('Sign Up')
  end

end