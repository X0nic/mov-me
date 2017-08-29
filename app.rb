require 'sinatra/base'
require 'sinatra/json'

require 'sidekiq'
require 'sidekiq/web'

require './lib/downloader'
require './lib/reply'
require './lib/feed_builder'
require './lib/settings'

require './workers/null_worker'
require './workers/download_worker'

class MovMeApp < Sinatra::Base

  get '/' do
    'Mov Me'
  end

  get '/test' do
    json frontend: :ok, backend: check_backend, config: check_config
  end

  post '/' do
    if Settings.sms_enabled?
      puts "SMS Incomming: #{params[:Body]} - received"
    else
      puts "SMS Incomming: #{params[:Body]}"
    end

    reply_message = Reply.new.run("Downloading #{params[:Body]}")

    DownloadWorker.perform_async(params[:Body], params[:From])
    # Downloader.new.run(url: params[:Body], to: params[:From])
    # Downloader.new(settings).background_run(params[:Body])

    reply_message
  end

  private
  def check_backend
    NullWorker.perform_async(rand(30))
    :ok
  rescue => e
    puts e
    :fail
  end

  def check_config
    Settings.loaded? ? :ok : :fail
  rescue
    :fail
  end
end
