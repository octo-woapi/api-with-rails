# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #index' do
    context 'when there is no product' do
      before { get :index, format: :json }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end

    context 'when there are some products' do
      before do
        create_list :product, 2
        get :index, format: :json
      end

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: product_id }, format: :json }

    context 'when product ID does not exist' do
      let(:product_id) { 999 }

      it('returns http not_found') { expect(response).to have_http_status(:not_found) }
    end

    context 'when product ID exists' do
      let(:product) { create :product }
      let(:product_id) { product.id }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end

  describe 'POST #create' do
    let(:sample_product) { build :product }

    before { post :create, params: product_params, format: :json }

    context 'when all parameters are provided' do
      let(:product_params) { { name: sample_product.name, price: sample_product.price, weight: sample_product.weight } }

      it('returns http created') { expect(response).to have_http_status(:created) }
      it('returns header location') { expect(response.headers['Location']).not_to be_blank }
    end

    context 'when some parameters are missing' do
      let(:product_params) { { name: sample_product.name } }

      it('returns http bad_request') { expect(response).to have_http_status(:bad_request) }
      it('returns a json error') do
        expect(response.body).to include('Validation failed')
        expect(response.body).to include('Price')
        expect(response.body).to include('Weight')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
