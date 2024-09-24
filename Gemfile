source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.5'

gem 'rails', '~> 7.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 6.4', '>= 6.4.2'
gem 'dartsass-sprockets'
gem 'terser'
gem 'coffee-rails', '~> 5.0'
gem 'jbuilder', '~> 2.12'
gem 'bootsnap', '~> 1.18', '>= 1.18.4', require: false

gem 'rubocop', '1.66.1'
gem 'rollbar'

gem 'redis-rails'

gem 'devise'
gem 'devise-i18n'

gem 'bootstrap', '~> 5.3.3'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'select2-rails'

gem 'eventbrite_sdk'
gem 'http'
gem 'gibbon'

gem 'kaminari'
gem 'bootstrap4-kaminari-views'

gem 'postmark-rails'

gem 'recaptcha'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'brakeman', require: false
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'climate_control'
end

group :development do
  gem 'web-console', '~> 4.2', '>= 4.2.1'
  gem 'listen', '~> 3.9'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
  gem 'httplog'
  gem 'faker'
  gem 'dockerfile-rails', '>= 1.6'
end

group :test do
  gem 'capybara', '~> 3.40'
  gem 'capybara-email'
  gem 'webdrivers', '~> 5.3', '>= 5.3.1', require: false
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
