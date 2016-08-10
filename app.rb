#! /usr/bin/env ruby

config_file 'config.yml'

get '/' do
  'Mov Me'
end

get '/test' do
  Reply.new(settings).run("hello")
end

post '/' do
  if settings.sms_enabled
    puts "SMS Incomming: #{params[:Body]} - received"
  else
    puts "SMS Incomming: #{params[:Body]}"
  end

  reply_message = Reply.new(settings).run("Downloading #{params[:Body]}")

  Downloader.new(settings: settings).run(url: params[:Body], to: params[:From])
  # Downloader.new(settings).background_run(params[:Body])

  reply_message
end
