class BasePage
  include PageObject
  include RSpec::Matchers

  h1(:signup_page, name: 'signup')
  h1(:signin_page, name: 'signin')

  def get_text(element_name)
    wait_for_element(element_name)
    attempts = 1
    text = ""
    begin
      text = send("#{element_name}_element").text if send("#{element_name}_element").exists?
    rescue
      attempts += 1
      retry if attempts < 3
    end
    text.to_s
  end

  def get_page_title
    get_text('page_title')
  end

  def element_present?(element_or_name, timeout: nil)
    element = resolve_element element_or_name
    if timeout
      Watir::Wait.until(timeout: timeout) { element.exists? && element.present? }
    else
      element.exists? && element.present?
    end
  rescue Watir::Exception::UnknownObjectException, Watir::Wait::TimeoutError
    false
  end

  def resolve_element(element_or_name, plural = false)
    if element_or_name.is_a?(String) || element_or_name.is_a?(Symbol)
      send("#{element_or_name}_element#{plural ? 's' : ''}")
    else
      element_or_name
    end
  end

  def wait_for_element(element_or_name, options = {})
    element = resolve_element element_or_name
    timeout = options.delete(:timeout) || 15
    message = options.delete(:message) || "Locating element '#{element_or_name}'."
    raise "Invalid options: #{options}" unless options.empty?
    do_until_true(message, timeout: timeout) { element_present? element }
  end

end