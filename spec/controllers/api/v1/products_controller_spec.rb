# frozen_string_literal: true

require 'rails_helper'

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
end
