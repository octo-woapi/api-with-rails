# frozen_string_literal: true

class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_amount
    product.price * quantity
  end

  def total_weight
    product.weight * quantity
  end
end
