# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  accepts_nested_attributes_for :order_products

  validates :shipment_amount, :total_amount, :weight, presence: true, if: :paid?

  enum status: { pending: 0, paid: 1, canceled: 2 }

  before_validation :initialize_status, on: :create
  before_create :compute_weight
  before_create :compute_total_amount
  before_create :compute_shipment_amount, unless: ->(order) { order.order_products.empty? }

  private

  def initialize_status
    self.status = :pending
  end

  def compute_total_amount
    self.total_amount = order_products.reduce(0.0) do |total_amount, order_product|
      total_amount + order_product.total_amount
    end
    self.total_amount *= 0.95 if total_amount >= 1000
  end

  def compute_weight
    self.weight = order_products.reduce(0) do |weight, order_product|
      weight + order_product.total_weight
    end
  end

  def compute_shipment_amount
    self.shipment_amount = (weight.to_f / 25.0).floor * 10
  end
end
