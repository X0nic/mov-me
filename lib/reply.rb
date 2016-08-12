require 'twilio-ruby'

class Reply
  def run(msg)
    if Settings.sms_enabled?
      puts "SMS Reply: #{msg} - sent"
    else
      puts "SMS Reply: #{msg}"
    end

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message msg
    end
    twiml.text
  end
end
