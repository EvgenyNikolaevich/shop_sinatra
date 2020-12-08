# frozen_string_literal: true

module Domains
  module Stock
    module Sequences
      class GetAll < LunaPark::Interactors::Sequence
        # Get all stocks
        # @return [Array<Entity::Stock>]
        def call!
          Repositories::Stock.new.all
        end
      end
    end
  end
end
