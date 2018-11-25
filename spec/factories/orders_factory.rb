# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    factory :order_with_products do
      transient do
        quantity { Random.rand(1..5) }
        product_id do
          product = create :product
          product.id
        end
      end

      initialize_with do
        attributes = [{
          product_id: product_id,
          quantity: quantity
        }]
        Order.create!(order_products_attributes: attributes)
      end
    end
  end
end
