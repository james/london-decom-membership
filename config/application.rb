require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LondonDecomMembership
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    if (ENV.fetch('REDIS_URL', nil) && ENV.fetch('REDIS_PORT', nil)) && !Rails.env.test?
      config.cache_store = :redis_cache_store, {
        url: ENV.fetch('REDIS_URL', nil), port: ENV.fetch('REDIS_PORT', nil), db: 0, namespace: 'cache',
        expires_in: 90.minutes
      }

      config.session_store :redis_store,
                           servers: [{
                             url: ENV.fetch('REDIS_URL', nil),
                             port: ENV.fetch('REDIS_PORT', nil),
                             db: 0,
                             namespace: 'session'
                           }],
                           expire_after: 90.minutes,
                           key: "_#{Rails.application.class.module_parent_name.downcase}_session",
                           threadsafe: true,
                           secure: true
    end
  end
end
