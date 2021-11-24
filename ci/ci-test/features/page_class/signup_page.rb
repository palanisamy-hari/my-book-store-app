require_relative './base_page'

class SignupPage < BasePage

  text_field(:sign_up_email, name: 'email', id: 'email')
  text_field(:sign_up_password, name: 'password', id: 'password')
  button(:sign_up_button, id: 'signup_btn')
end