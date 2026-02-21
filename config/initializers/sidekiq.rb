Sidekiq.strict_args!(:warn) # https://github.com/sidekiq/sidekiq/blob/main/docs/7.0-Upgrade.md#strict-arguments

redis_url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')
redis_config = { url: redis_url }

if redis_url.start_with?('rediss://')
  redis_config[:ssl_params] = { verify_mode: OpenSSL::SSL::VERIFY_NONE }
end

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
