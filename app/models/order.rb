# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :shipment_amount, :total_amount, :weight, presence: true

  enum status: %i[pending paid canceled]

  before_create :initialize_status

  def initialize_status
    self.status = :pending
  end
end
