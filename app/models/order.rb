# frozen_string_literal: true

class Order < ApplicationRecord
  validates :shipment_amount, :total_amount, :weight, presence: true
end
