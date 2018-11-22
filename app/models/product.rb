# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, :price, :weight, presence: true

  scope :sort, ->(parameter) { order(parameter).order(created_at: :desc) }
end
