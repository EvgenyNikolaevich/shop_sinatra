# frozen_string_literal: true

module Domains
  module Stock
    module Forms
      class Update < LunaPark::Forms::Simple
        validator Validators::Update

        def perform(_valid_params)
          Sequences::Update.call(id: id, bearer_id: bearer_id)
        end

        private

        def id
          valid_params.dig(:data, :id)
        end

        def bearer_id
          valid_params.dig(:data, :attributes, :bearer_id)
        end
      end
    end
  end
end
