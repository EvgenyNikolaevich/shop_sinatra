# frozen_string_literal: true

require 'webmock/rspec'

ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require File.expand_path('../config/boot', __dir__)

Dir['./spec/shared/**/*.rb'].sort.each(&method(:require))
Dir['./spec/*/factories/**/*.rb'].sort.each(&method(:require))

module RSpecMixin
  include Rack::Test::Methods
  def app
    Rack::Builder.new do
      use Rack::JSONBodyParser
      run Rack::URLMap.new('/api/v1' => Api)
    end
  end
end

db_cleaner = DatabaseCleaner[:sequel, connection: DB]

RSpec.configure do |config|
  config.include RSpec::JsonExpectations::Matchers

  config.color     = true
  config.formatter = :documentation

  config.mock_with   :rspec
  config.expect_with :rspec

  config.raise_errors_for_deprecations!
  config.include RSpecMixin

  config.include FactoryBot::Syntax::Methods
  config.before(:suite) { FactoryBot.find_definitions }

  config.before(:suite) { db_cleaner.clean_with :truncation }
  config.before(:each)  { db_cleaner.strategy = :transaction }
  config.before(:each)  { db_cleaner.start }
  config.after(:each)   { db_cleaner.clean }
  config.after(:suite)  { db_cleaner.clean_with :truncation }
end
