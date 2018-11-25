# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::UpdateOrder do
  describe '.with_products!' do
    subject(:create_order_with_products) { described_class.with_products!(order, params) }

    let(:order) { create :order }

    before { allow(order).to receive(:update!) }

    context 'when order contains products' do
      let(:params) do
        {
          status: 'paid',
          products: [{
            id: 3,
            quantity: 1
          }]
        }
      end

      before { create_order_with_products }

      it 'updates the order' do
        attributes = [{ product_id: 3, quantity: 1 }]
        expect(order).to have_received(:update!).with(status: 'paid', order_products_attributes: attributes)
      end
    end

    # context 'when order products array is empty' do
    #   let(:params) { { products: [] } }

    #   it('raises error') { expect { create_order_with_products }.to raise_error(StandardError) }
    # end
  end
end
