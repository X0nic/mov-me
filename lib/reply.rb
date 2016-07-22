require 'twilio-ruby'

class Reply
  def initialize(settings)
    @settings = settings
  end

  def run(msg)
    if @settings.sms_enabled
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
