def retry_with(opts = {}, &blk)
  fail('Block is required') if blk.nil?

  classes = [opts[:errors]]
  attempts = opts[:attempts] || 3
  delay = opts[:delay] || 1
  delay_inc = opts[:increment_delay] == true
  delay_sleep = opts[:sleep] == true
  debug = opts[:debug] == true
  custom_message = opts[:message]

  1.upto attempts do |i|
    begin
      puts "Trying #{i} attempt..." if debug
      blk.call
      puts "Success" if debug
    rescue StandardError => @err
      puts "An Error on #{i} attempt: #{@err}" if debug

      if (classes & @err.class.ancestors).any?
        delay *= i if delay_inc
        sleep(delay) if delay_sleep
      else
        puts "UnHandled Error; Couldn't retry: #{@err}" if debug
        fail(@err)
      end
    end
  end

  failure_msg = if custom_message
                  "Retry attempts exhausted (#{attempts} total).\n" + custom_message
                else
                  "Retry attempts exhausted (#{attempts} total).\n"
                end
  fail @err, failure_msg

end