# frozen_string_literal: true

module Abstract
  class Adapter
    def base_url
      raise NotImplementedError
    end

    private

    def post(path:, body:)
      send_request(:post, path, body)
    end

    def send_request(method, path, body)
      RestClient::Request.execute(
        method: method,
        url: (URI(base_url) + path).to_s,
        payload: body,
        headers: headers,
        log: logger
      )
    end

    def logger
      Logger.new($stdout)
    end

    # Default request headers
    HEADERS = { content_type: :json }.freeze

    def headers
      HEADERS
    end
  end
end
