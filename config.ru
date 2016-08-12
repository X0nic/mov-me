require './app'
require './config'

map '/' do
  run MovMeApp
end

map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == Settings.sidekiq_username && password == Settings.sidekiq_password
  end

  run Sidekiq::Web
end

