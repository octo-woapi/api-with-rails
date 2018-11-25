# frozen_string_literal: true

products = FactoryBot.create_list :product, 20
orders = FactoryBot.create_list :order_with_products, 10

(1..5).each do |_|
  FactoryBot.create :order_product, order: orders.sample, product: products.sample
end

FactoryBot.create_list :bill, 10
