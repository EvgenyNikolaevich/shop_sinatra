# frozen_string_literal: true

module Requests
  class Handler
    attr_reader :error

    def catch
      yield
    rescue RestClient::ExceptionWithResponse => e
      @error =
        case e.response&.code
        when 400           then on_bad_request(e)
        when 401, 403      then on_unauthorized(e)
        when 404           then on_not_found(e)
        when 500, 501, nil then on_bad_gateway(e)
        else                    on_unknown(e)
        end
    end

    def error?
      error && true
    end

    private

    BAD_GATEWAY = { message: 'Service is temporary unavailable. Please try again later' }.freeze
    NOT_FOUND   = { message: 'Not found' }.freeze
    UNKNOWN     = { message: 'Something went wrong. Please try again later' }.freeze

    private_constant :BAD_GATEWAY, :NOT_FOUND, :UNKNOWN

    def on_unauthorized(exception)
      Notify.error(exception, response_body: exception.response&.body)
      response_error(exception) || UNKNOWN
    end

    def on_bad_request(exception)
      Notify.warning(exception, response_body: exception.response&.body)
      response_error(exception) || UNKNOWN
    end

    def on_not_found(exception)
      Notify.warning(exception, response_body: exception.response&.body)
      response_error(exception) || NOT_FOUND
    end

    def on_bad_gateway(exception)
      Notify.warning(exception, response_body: exception.response&.body)
      response_error(exception) || BAD_GATEWAY
    end

    def on_unknown(exception)
      Notify.error(exception, response_body: exception.response&.body)
      response_error(exception) || UNKNOWN
    end

    # Helpers

    # TODO: кастомизировать (если используется), либо отпилить файл целиком
    def response_error(diagnostic_exception)
      parsed_body = response_body(diagnostic_exception&.response&.body)
      parsed_body&.dig('__all__') || parsed_body
    end

    def response_body(response)
      JSON.parse(response)
    rescue JSON::ParserError
      nil
    end
  end
end
