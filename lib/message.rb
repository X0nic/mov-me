require 'twilio-ruby'

class Message
  def initialize(settings)
    @settings = settings
  end

  def send(message)
    account_sid = @settings.account_sid
    auth_token = @settings.auth_token

    client = Twilio::REST::Client.new account_sid, auth_token

    if @settings.sms_enabled
      client.messages.create(
        messaging_service_sid: @settings.messaging_service_sid,
        to: @settings.bcc_to,
        body: message
      )
      puts "SMS Message: #{message} - sent"
    else
      puts "SMS Message: #{message}"
    end
  end
end
