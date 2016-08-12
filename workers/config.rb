Sidekiq.configure_server do |config|
  config.redis = {
    host: Settings.redis_host
  }
end
