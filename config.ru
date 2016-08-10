require "sinatra"
require "sinatra/config_file"
require 'sidekiq/web'

require './app'
require './init'
require './config'

map '/' do
  run Sinatra::Application
end

map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == settings.sidekiq_username && password == settings.sidekiq_password
  end

  run Sidekiq::Web
end

