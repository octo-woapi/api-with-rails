# frozen_string_literal: true

FactoryBot.define do
  factory :order_product do
    association :order
    association :product
    quantity { Random.rand(1..10) }
  end
end
