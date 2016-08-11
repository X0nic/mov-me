Sidekiq.configure_client do |config|
  config.redis = {
    size: 1,
    host: MovMe.settings.redis_host
  }
end
