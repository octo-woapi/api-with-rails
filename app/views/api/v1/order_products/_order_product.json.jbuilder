# frozen_string_literal: true

if order_product
  json.id order_product.product_id
  json.extract! order_product, :quantity
end
