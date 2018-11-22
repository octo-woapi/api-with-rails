# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe 'associations' do
    subject(:order_product) { build :order_product }

    it do
      expect(order_product).to belong_to(:order)
      expect(order_product).to belong_to(:product)
    end
  end
end
