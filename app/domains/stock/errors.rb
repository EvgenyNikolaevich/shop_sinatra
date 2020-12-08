# frozen_string_literal: true

module Domains
  module Stock
    module Errors
      class StockAlreadyExists < LunaPark::Errors::Processing
        def message
          'Stock already exists'
        end
      end

      class StockDoesNotFound < LunaPark::Errors::Processing
        def message
          'Stock does not found'
        end
      end
    end
  end
end
