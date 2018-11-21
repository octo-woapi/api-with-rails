# frozen_string_literal: true

if product
  json.extract! product,
                :id,
                :name,
                :price,
                :weight

  # We change attributes case from snake_case to camelCase
  json.createdAt product.created_at
  json.updatedAt product.updated_at
end
