# frozen_string_literal: true

module Domains
  module Stock
    module Sequences
      class Delete < LunaPark::Interactors::Sequence
        attr_accessor :id

        # Safe delete stock
        # @return [Entity::Stock]
        def call!
          raise Errors::StockDoesNotFound unless Repositories::Stock.new.exists?(id)

          stock = Repositories::Stock.new.find(id)
          stock.deleted_at = Time.now.utc

          Repositories::Stock.new.update(stock)
        end
      end
    end
  end
end
