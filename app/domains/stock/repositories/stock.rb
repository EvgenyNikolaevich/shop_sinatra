# frozen_string_literal: true

module Domains
  module Stock
    module Repositories
      class Stock < LunaPark::Repositories::Sequel
        entity Entities::Stock
        mapper Mappers::Stock

        def exists?(id)
          !stocks.where(id: id).empty?
        end

        def find(id, for_update: false)
          ds = dataset.where(id: id)
          read_one(ds, for_update: for_update)
        end

        def create(input)
          entity = wrap(input)
          row    = to_row(entity)
          new_row = dataset.returning.insert(row).first
          new_attrs = from_row(new_row)
          entity.set_attributes(new_attrs)
          entity
        end

        def update(input)
          entity = wrap(input)
          entity.updated_at = Time.now.utc
          row = to_row(entity)
          new_row = dataset.returning.where(id: entity.id).update(row).first
          new_attrs = from_row(new_row)
          entity.set_attributes(new_attrs)
          entity
        end

        def all
          to_entities from_rows(stocks.where(deleted_at: nil))
        end

        private

        def read_one(dataset, for_update: false)
          dataset = dataset.for_update if for_update
          row = dataset.first
          to_entity from_row(row)
        end

        def dataset
          DB[:stocks]
        end

        alias stocks dataset
      end
    end
  end
end
