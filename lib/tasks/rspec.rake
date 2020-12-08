# frozen_string_literal: true

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  # If you cannot load 'rspec/core' file
  # you probable on `production` environment
  nil
end
