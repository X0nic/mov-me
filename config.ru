require "sinatra"
require "sinatra/config_file"
require 'sidekiq/web'

require './init'
require './config'
require './app'

run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)
