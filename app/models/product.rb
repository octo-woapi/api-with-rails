# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, :price, :weight, presence: true
end
