# Load the Rails application.
require_relative 'application'
require_relative 'initializers/rollbar'

notify = lambda do |e|
  Rollbar.with_config(use_async: false) do
    Rollbar.error(e)
  end
rescue StandardError
  Rails.logger.error 'Synchronous Rollbar notification failed. Sending async to preserve info'
  Rollbar.error(e)
end

begin
  # Initialize the Rails application.
  Rails.application.initialize!
rescue StandardError => e
  notify.call(e)
  raise
end
