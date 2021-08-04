def do_until_true(description = nil, options = {})
  options = description if description.is_a? Hash
  delay = options.delete(:delay) || 0.5
  timeout = options.delete(:timeout) || 0.5
  raise "Invalid options: #{options}" unless options.empty?
  start = Time.now
  stop = start + timeout
  @event_start = start
  until yield || @event_start >= stop
    sleep delay
    @event_start = Time.now
  end
  raise Timeout::Error, "Timed out, set time of '#{timeout}' seconds is over waiting for condition: '#{description}'" if @event_start >= stop
  true
end