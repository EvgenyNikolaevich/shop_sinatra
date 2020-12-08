# frozen_string_literal: true

module Domains
  module Stock
    module Forms
      class Create < LunaPark::Forms::Simple
        validator Validators::Create

        def perform(_valid_params)
          Sequences::Create.call(
            id: id,
            bearer_id: bearer_id,
            name: name
          )
        end

        private

        def id
          valid_params.dig(:data, :id)
        end

        def bearer_id
          valid_params.dig(:data, :attributes, :bearer_id)
        end

        def name
          valid_params.dig(:data, :attributes, :name)
        end
      end
    end
  end
end
