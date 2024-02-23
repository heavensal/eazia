# config/initializers/redis.rb
url = ENV["REDISCLOUD_URL"]
Sidekiq.strict_args!(false)

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
end
