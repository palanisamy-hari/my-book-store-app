require_relative './base_page'

class HomePage < BasePage

  link(:sign_up, href: '/user/signup')
  link(:sign_in, href: '/user/signin')
  link(:logout, href: '/user/logout')
  div(:user_profile, class: %w{col-md-8 col-md-offset-2})
  link(:books_link, href: '/books')

  def open_signup_page
    self.sign_up_element.click
    wait_for_element('sign_up_page')
    expect(self.signup_page).to eq('Sign Up')
  end

  def open_signin_page
    self.sign_in_element.click
    wait_for_element('signin_page')
    expect(self.signin_page).to eq('Sign Up')
  end

  def open_books_page
    self.books_link_element.click
    wait_for_element('books_page')
    expect(self.signup_page).to eq('Sign Up')
  end

end