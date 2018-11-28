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

  describe 'default status is pending' do
    subject(:order) { create :order_with_products }

    it { expect(order.status).to eq('pending') }
  end

  describe 'update to paid' do
    describe 'when order contains products' do
      let(:order) { create :order_with_products }

      describe 'effective status change' do
        before { order.update! status: :paid }

        it { expect(order.status).to eq('paid') }
      end

      describe 'bill creation' do
        before { order.update! status: :paid }

        it { expect(Bill.last&.order_id).to eq(order.id) }
      end
    end

    describe 'when order does not contain products' do
      let(:order) { create :order }

      it { expect { order.update! status: :paid }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    describe 'when order is canceled' do
      let(:order) { create :order, status: :canceled }

      it { expect { order.update!(status: :pending) }.to raise_error(ActiveRecord::ReadOnlyRecord) }
    end
  end

  describe 'create order with products' do
    subject(:order) { Order.create!(order_products_attributes: order_products) }

    describe 'all products exist' do
      let(:products) { create_list :product, 2 }

      let(:order_products) do
        [
          {
            product_id: products[0].id,
            quantity: 1
          },
          {
            product_id: products[1].id,
            quantity: 3
          }
        ]
      end

      it do
        expect(order).to be_an(Order)
        expect(order.products.count).to eq(2)
        expect(order.order_products.map(&:quantity)).to eq([1, 3])
      end
    end

    describe 'one product does not exist' do
      let(:order_products) do
        [
          {
            product_id: 999,
            quantity: 1
          }
        ]
      end

      it { expect { order }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe 'compute attributes before saving' do
    let(:order_products) do
      [
        {
          product_id: product1.id,
          quantity: 1
        },
        {
          product_id: product2.id,
          quantity: 2
        }
      ]
    end

    let!(:order) { Order.create!(order_products_attributes: order_products) }

    describe 'when products have a regular price and are light' do
      let(:product1) { create :product, price: 10, weight: 10 }
      let(:product2) { create :product, price: 20, weight: 5 }

      it 'has neither a discount nor a shipment amount' do
        expect(order.shipment_amount).to eq(0)
        expect(order.total_amount).to eq(50)
        expect(order.weight).to eq(20)
      end
    end

    describe 'when products have a high price and are heavy' do
      let(:product1) { create :product, price: 400, weight: 30 }
      let(:product2) { create :product, price: 500, weight: 25 }

      # TODO: Check if shipment amount should be added to total amount or not
      it 'has a 5% discount and a shipment amount' do
        expect(order.shipment_amount).to eq(30)
        expect(order.total_amount).to eq(1330.0)
        expect(order.weight).to eq(80)
      end
    end
  end
end
