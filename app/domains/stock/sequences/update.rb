# frozen_string_literal: true

module Domains
  module Stock
    module Sequences
      class Update < LunaPark::Interactors::Sequence
        attr_accessor :id, :bearer_id

        # Update stock
        # @return [Entity::Stock]
        def call!
          raise Errors::StockDoesNotFound unless Repositories::Stock.new.exists?(id)

          stock = Repositories::Stock.new.find(id)
          stock.bearer_id = bearer_id

          Repositories::Stock.new.update(stock)
        end
      end
    end
  end
end
