# frozen_string_literal: true

module Helpers
  module Endpoints
    def submit!(form, serialize_error: true, notify: false)
      if form.submit
        yield form
      else
        status 400
        Notify.error('Validation error', errors: form.errors, params: params) if notify
        serialize_error ? JSONAPI::Serializer.serialize_errors(form.errors).to_json : nil
      end
    end

    def check!(result, serialize_error: true, notify: false)
      if result.success?
        yield result
      else
        status 422
        Notify.error(result.fail_message, params: params) if notify
        serialize_error ? JSONAPI::Serializer.serialize_errors(result.fail_message).to_json : nil
      end
    end

    def found!(value)
      value ? yield(value) : halt(404)
    end
  end
end
