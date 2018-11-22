# frozen_string_literal: true

class Bill < ApplicationRecord
  validates :amount, presence: true
end
