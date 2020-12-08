# frozen_string_literal: true

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError
  # If you cannot load 'rubocop/rake_task' file
  # you probable on `production` environment
  nil
end
