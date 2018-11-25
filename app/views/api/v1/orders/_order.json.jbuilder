# frozen_string_literal: true

if order
  json.extract! order,
                :id,
                :shipment_amount,
                :total_amount,
                :weight,
                :status

  json.products do
    json.array! order.order_products, partial: 'api/v1/order_products/order_product', as: :order_product
  end

  # We change attributes case from snake_case to camelCase
  json.createdAt order.created_at
  json.updatedAt order.updated_at
end
