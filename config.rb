Sidekiq.configure_client do |config|
  config.redis = {
    size: 1,
    host: Settings.redis_host
  }
end
