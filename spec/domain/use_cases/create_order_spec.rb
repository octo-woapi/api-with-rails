# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::CreateOrder do
  describe '.with_products!' do
    subject(:create_order_with_products) { described_class.with_products!(order) }

    before { allow(Order).to receive(:create!) }

    context 'when order contains products' do
      let(:order) do
        {
          products: [{
            id: 3,
            quantity: 1
          }]
        }
      end

      before { create_order_with_products }

      it 'creates the order' do
        attributes = [{ product_id: 3, quantity: 1 }]
        expect(Order).to have_received(:create!).with(order_products_attributes: attributes)
      end
    end

    context 'when order does not contain products key' do
      let(:order) { {} }

      # TODO: Change for a more explicit error
      it('raises error') { expect { create_order_with_products }.to raise_error(StandardError) }
    end

    context 'when order products array is empty' do
      let(:order) { { products: [] } }

      it('raises error') { expect { create_order_with_products }.to raise_error(StandardError) }
    end
  end
end
