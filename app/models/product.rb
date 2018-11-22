# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, :price, :weight, presence: true

  scope :sort, ->(parameter) { order(parameter).order(:created_at) }
end
