# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    shipment_amount { Random.rand(0..3) * 10 }
    total_amount { Random.rand(3.0..100.0).round(2) }
    weight { Random.rand(1..30) }
  end
end
