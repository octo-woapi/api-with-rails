# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::CreateOrder do
  describe '.with_products!' do
    let(:order) do
      {
        products: [{
          id: 3,
          quantity: 1
        }]
      }
    end

    before do
      allow(Order).to receive(:create!)
      described_class.with_products!(order)
    end

    it 'creates the order' do
      attributes = [{ product_id: 3, quantity: 1 }]
      expect(Order).to have_received(:create!).with(order_products_attributes: attributes)
    end
  end
end
