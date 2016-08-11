require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/json'

require 'sidekiq'
require 'sidekiq/web'

require './lib/downloader'
require './lib/reply'

require './workers/null_worker'

class MovMe < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.{yml,yml.erb}'

  get '/' do
    'Mov Me'
  end

  get '/test' do
    json frontend: :ok, backend: check_backend
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

  private
  def check_backend
    NullWorker.perform_async(rand(30))
    :ok
  rescue
    :fail
  end
end
