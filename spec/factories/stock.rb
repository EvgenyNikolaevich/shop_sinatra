# frozen_string_literal: true

FactoryBot.define do
  factory :stock, class: 'Domains::Stock::Entities::Stock' do
    trait :stub do
      created_at { Time.now.utc }
      updated_at { Time.now.utc }
    end

    id         { generate(:id) }
    name       { 'Some goods' }
    bearer_id  { generate(:id) }
    deleted_at {}

    initialize_with do
      Domains::Stock::Entities::Stock.wrap(attributes)
    end

    to_create do |instance|
      Domains::Stock::Repositories::Stock.new.create(instance)
    end
  end
end
