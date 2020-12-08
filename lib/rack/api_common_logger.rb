# frozen_string_literal: true

# Disable logging for `GET /health` endpoint

module Rack
  class ApiCommonLogger < CommonLogger
    def log(env, status, header, began_at)
      return if env['sinatra.route'] == 'GET /health'

      super
    end
  end
end
