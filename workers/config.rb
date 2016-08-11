Sidekiq.configure_server do |config|
  config.redis = {
    host: MovMe.settings.redis_host
  }
end
