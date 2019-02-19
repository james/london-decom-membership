require 'rubocop/rake_task'
task default: %i[rubocop spec] if Rails.env.test? || Rails.env.development?
