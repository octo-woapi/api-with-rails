# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    amount { 1.5 }
    association :order
  end
end
