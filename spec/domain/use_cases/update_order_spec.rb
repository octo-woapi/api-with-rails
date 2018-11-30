# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::UpdateOrder do
  describe '.with_products!' do
    let(:order) { create :order }
    let(:params) do
      {
        status: 'paid',
        products: [{
          id: 3,
          quantity: 1
        }]
      }
    end

    before do
      allow(order).to receive(:update!)
      described_class.with_products!(order, params)
    end

    it 'updates the order' do
      attributes = [{ product_id: 3, quantity: 1 }]
      expect(order).to have_received(:update!).with(status: 'paid', order_products_attributes: attributes)
    end
  end
end
