# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :order

  validates :amount, presence: true
end
