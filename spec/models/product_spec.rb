# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject(:product) { build :product }

    it do
      expect(product).to validate_presence_of :name
      expect(product).to validate_presence_of :price
      expect(product).to validate_presence_of :weight
    end
  end

  describe 'scopes' do
    describe '.sort' do
      it do
        create :product, name: 'Red Skirt'
        create :product, name: 'Black Dress'

        products = Product.sort('name')

        expect(products.map(&:name)).to eq(['Black Dress', 'Red Skirt'])
      end
    end
  end
end
