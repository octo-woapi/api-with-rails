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
    let(:order) { create :order }

    describe 'when order is pending and has no products' do
      it 'does not have weight, total_amount, shipment_amount' do
        expect(order.weight).to eq(0)
        expect(order.total_amount).to eq(0.0)
        expect(order.shipment_amount).to be_nil
      end
    end

    describe 'when order is paid' do
      let(:order) { create :order_with_products, status: :paid }

      it('must have a weight') do
        expect { order.update!(weight: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it('must have a total_amount') do
        expect { order.update!(total_amount: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it('must have a shipment_amount') do
        expect { order.update!(shipment_amount: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'default status is pending' do
    subject(:order) { create :order_with_products }

    it { expect(order.status).to eq('pending') }
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
    let(:product1) { create :product, price: 10, weight: 30 }
    let(:product2) { create :product, price: 20, weight: 25 }

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

    it do
      expect(order.shipment_amount).to eq(30)
      expect(order.total_amount).to eq(50)
      expect(order.weight).to eq(80)
    end
  end
end
