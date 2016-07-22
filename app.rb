require "sinatra"
require "sinatra/config_file"

require './lib/downloader'
require './lib/reply'

config_file 'config.yml'

post '/' do
  if settings.sms_enabled
    puts "SMS Incomming: #{params[:Body]} - received"
  else
    puts "SMS Incomming: #{params[:Body]}"
  end

  reply_message = Reply.new(settings).run("Downloading #{params[:Body]}")

  Downloader.new(settings).run(params[:Body])

  reply_message
end
