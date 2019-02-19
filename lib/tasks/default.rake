require 'rubocop/rake_task'
task default: %i[rubocop brakeman:run spec] if Rails.env.test? || Rails.env.development?
