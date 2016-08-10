Sidekiq.configure_client do |config|
  config.redis = {
    size: 1,
    host: ENV['REDIS_SERVICE_HOST']
  }
end
