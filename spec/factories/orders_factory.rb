# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    shipment_amount { 1.5 }
    total_amount { 1.5 }
    weight { 1 }
  end
end
