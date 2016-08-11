require './app'
require './config'

map '/' do
  run MovMe
end

map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == MovMe.settings.sidekiq_username && password == MovMe.settings.sidekiq_password
  end

  run Sidekiq::Web
end

