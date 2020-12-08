# frozen_string_literal: true

module Domains
  module Stock
    module Sequences
      class Create < LunaPark::Interactors::Sequence
        attr_accessor :id, :bearer_id, :name

        # Create stock
        # @return [Entity::Stock]
        def call!
          raise Errors::StockAlreadyExists if Repositories::Stock.new.exists?(id)

          entity = Entities::Stock.new(id: id, bearer_id: bearer_id, name: name)
          Repositories::Stock.new.create(entity)
        end
      end
    end
  end
end
