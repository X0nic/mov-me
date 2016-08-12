require 'twilio-ruby'

class Message
  def send(message:, to:)
    account_sid = Settings.account_sid
    auth_token = Settings.auth_token

    client = Twilio::REST::Client.new account_sid, auth_token

    if Settings.sms_enabled?
      client.messages.create(
        messaging_service_sid: Settings.messaging_service_sid,
        to: to,
        body: message
      )
      puts "SMS Message: #{to} #{message} - sent"
    else
      puts "SMS Message: #{to} #{message}"
    end
  end
end
