# frozen_string_literal: true

source 'https://rubygems.org'

# Webserver
gem 'dotenv'
gem 'puma'
gem 'rack'
gem 'rack-contrib' # For convert request body to params see ./config.ru
gem 'rack-cors'    # For enable CORS ./config.ru

# Framework
gem 'luna_park', git: 'https://github.com/am-team/luna_park.git'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'zeitwerk' # For autoload path see ./config/boot.rb

# Validators
gem 'dry-validation'

# Models
gem 'pg'
gem 'sequel'

# Views
gem 'jsonapi-serializers'

# System
gem 'rack-rewrite'
gem 'racksh'
gem 'rake'
gem 'rest-client'

group :development, :test do
  gem 'factory_bot'
  gem 'pry'
  gem 'rack-test'
  gem 'rerun' # Code autoreload after change files in dev mode
  gem 'rspec'
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-json_expectations'
  gem 'webmock'
end

group :development do
  gem 'git', require: false
end
