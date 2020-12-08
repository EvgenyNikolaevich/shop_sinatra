# frozen_string_literal: true

module Domains
  module Stock
    module Mappers
      class Stock < LunaPark::Mappers::Simple
        class << self
          def from_row(row)
            return if row.nil?

            {
              id: row[:id],
              bearer_id: row[:bearer_id],
              name: row[:name],
              created_at: row[:created_at],
              updated_at: row[:updated_at],
              deleted_at: row[:deleted_at]
            }
          end

          def to_row(input)
            attrs = input.to_h
            row = {}
            row[:id]         = attrs[:id] if attrs.key?(:id)
            row[:bearer_id]  = attrs[:bearer_id]
            row[:name]       = attrs[:name]
            row[:created_at] = attrs[:created_at] if attrs.key?(:created_at)
            row[:updated_at] = attrs[:updated_at] if attrs.key?(:updated_at)
            row[:deleted_at] = attrs[:deleted_at] if attrs.key?(:deleted_at)
            row
          end
        end
      end
    end
  end
end
