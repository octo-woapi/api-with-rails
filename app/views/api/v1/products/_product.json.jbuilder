# frozen_string_literal: true

if product
  json.extract! product,
                :id,
                :name,
                :price,
                :weight

  json.createdAt product.created_at
  json.updatedAt product.updated_at
end
