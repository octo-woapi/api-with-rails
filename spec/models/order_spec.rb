# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    subject(:order) { build :order }

    it do
      expect(order).to have_many(:order_products)
      expect(order).to have_many(:products)
    end
  end

  describe 'validations' do
    subject(:order) { build :order }

    it do
      expect(order).to validate_presence_of :shipment_amount
      expect(order).to validate_presence_of :total_amount
      expect(order).to validate_presence_of :weight
    end
  end
end
