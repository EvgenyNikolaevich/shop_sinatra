# frozen_string_literal: true

module Domains
  module Stock
    module Serializers
      class Stock
        include JSONAPI::Serializer

        attribute(:bearer_id)
        attribute(:name)

        attribute(:created_at) { Time.now.utc.iso8601(10) }
        attribute(:updated_at) { Time.now.utc.iso8601(10) }
        attribute(:deleted_at)

        def self_link; end

        def format_name(attribute_name)
          attribute_name.to_s
        end
      end
    end
  end
end
