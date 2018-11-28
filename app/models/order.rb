# frozen_string_literal: true

class OrderValidator < ActiveModel::Validator
  def validate(record)
    return if record.products? || !record.will_save_change_to_attribute?(:status, from: 'pending', to: 'paid')

    record.errors.add(:status, :paid_without_products)
  end
end

class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  accepts_nested_attributes_for :order_products

  enum status: { pending: 0, paid: 1, canceled: 2 }

  validates_with OrderValidator

  before_validation :initialize_status, on: :create

  before_create :compute_weight
  before_create :compute_total_amount
  before_create :compute_shipment_amount, if: :products?

  after_update :generate_bill, if: ->(order) { order.saved_change_to_attribute?(:status, from: 'pending', to: 'paid') }

  def products?
    !order_products.empty?
  end

  private

  def initialize_status
    self.status ||= :pending
  end

  def readonly?
    canceled? ? true : false
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

  def generate_bill
    return unless total_amount && shipment_amount

    Bill.create!(amount: (total_amount + shipment_amount), order: self)
  end
end
