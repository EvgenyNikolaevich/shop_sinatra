# frozen_string_literal: true

module Endpoints
  class Health < Sinatra::Base
    set :raise_errors, true

    get '/health' do
      DB.test_connection
    rescue Sequel::Error
      halt 500
    end
  end
end
