source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'rails', '~> 6.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'rubocop', '0.74'
gem 'rollbar'

gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'

gem 'bootstrap'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'select2-rails'

gem 'eventbrite_sdk'
gem 'http'
gem 'gibbon'

gem 'kaminari'
gem 'bootstrap4-kaminari-views'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'brakeman', require: false
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'climate_control'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'httplog'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'capybara-email'
  gem 'webdrivers', '~> 5.0', require: false
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
