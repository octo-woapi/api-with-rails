# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    subject(:product) { build :product }

    it do
      expect(product).to have_many(:order_products)
      expect(product).to have_many(:orders)
    end
  end

  describe 'validations' do
    subject(:product) { build :product }

    it do
      expect(product).to validate_presence_of :name
      expect(product).to validate_presence_of :price
      expect(product).to validate_presence_of :weight
    end
  end

  describe 'scopes' do
    describe '.order_by' do
      it do
        create :product, name: 'Red Skirt'
        create :product, name: 'Black Dress'

        products = Product.order_by('name')

        expect(products.map(&:name)).to eq(['Black Dress', 'Red Skirt'])
      end
    end
  end
end
