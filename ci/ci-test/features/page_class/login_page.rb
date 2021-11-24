require_relative './base_page'

class LoginPage < BasePage

  text_field(:sign_in_email, name: 'email', id: 'email')
  text_field(:sign_in_password, name: 'password', id: 'password')
  button(:sign_in, id: 'signin_btn')


end