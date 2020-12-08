# frozen_string_literal: true

module Domains
  module Stock
    module Validators
      class Create < LunaPark::Validators::Dry
        ID_PATTERN = /\A\d+\Z/.freeze

        validation_schema do
          params do
            required(:data).hash do
              required(:id).filled(:string, format?: ID_PATTERN)
              required(:type).value(:string, eql?: 'stocks')
              required(:attributes).hash do
                required(:bearer_id).value(:string, format?: ID_PATTERN)
                required(:name).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
