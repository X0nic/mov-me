Sidekiq.configure_client do |config|
  config.redis = {
    size: 1,
    host: settings.redis_host
  }
end
