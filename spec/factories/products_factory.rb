# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Random.rand(2..100) }
    weight { Random.rand(1..30) }
  end
end
