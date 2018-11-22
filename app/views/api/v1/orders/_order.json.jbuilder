# frozen_string_literal: true

if order
  json.extract! order,
                :id,
                :shipment_amount,
                :total_amount,
                :weight

  # We change attributes case from snake_case to camelCase
  json.createdAt order.created_at
  json.updatedAt order.updated_at
end
