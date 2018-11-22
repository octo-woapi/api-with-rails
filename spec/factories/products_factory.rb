# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Random.rand(2.0..100.0).round(2) }
    weight { Random.rand(1..30) }
  end
end
