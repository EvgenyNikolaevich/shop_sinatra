# frozen_string_literal: true

require 'rake'
require_relative 'config/environment'
require_relative 'config/root'
require_relative 'config/config'

# tasks from lib directory
Dir[File.expand_path('../lib/tasks/*.rake', __FILE__)].each do |entity|
  load entity
end

task default: [:spec, :rubocop]

task :environment do
  APP_ENV
end