require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LondonDecomMembership
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    if (ENV.fetch('REDIS_URL', nil) && ENV.fetch('REDIS_PORT', nil)) && !Rails.env.test?
      config.cache_store = :redis_cache_store, {
        url: ENV.fetch('REDIS_URL', nil), port: ENV.fetch('REDIS_PORT', nil), db: 0, namespace: 'cache',
        expires_in: 90.minutes
      }

      config.action_controller.enable_fragment_cache_logging = !Rails.env.production?

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
