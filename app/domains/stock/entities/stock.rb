# frozen_string_literal: true

module Domains
  module Stock
    module Entities
      class Stock < LunaPark::Entities::Nested
        attr :id
        attr :bearer_id
        attr :name

        attr :created_at
        attr :updated_at
        attr :deleted_at
      end
    end
  end
end
