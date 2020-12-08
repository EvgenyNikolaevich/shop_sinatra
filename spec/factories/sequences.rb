# frozen_string_literal: true

FactoryBot.define do
  sequence :id do
    rand(1..10_000)
  end
end
