# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'GET #index' do
    context 'when there is no order' do
      before { get :index, format: :json }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end

    context 'when there are some orders' do
      before do
        create_list :order, 2
        get :index, format: :json
      end

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order_id }, format: :json }

    context 'when order ID does not exist' do
      let(:order_id) { 999 }

      it('returns http not_found') { expect(response).to have_http_status(:not_found) }
    end

    context 'when order ID exists' do
      let(:order) { create :order }
      let(:order_id) { order.id }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end

  describe 'POST #create' do
    let(:sample_order) { build :order }

    before { post :create, params: create_params, format: :json }

    context 'when all parameters are provided' do
      let(:create_params) { { shipment_amount: sample_order.shipment_amount, total_amount: sample_order.total_amount, weight: sample_order.weight } }

      it('returns http created') { expect(response).to have_http_status(:created) }
      it('returns header location') { expect(response.headers['Location']).not_to be_blank }
    end

    context 'when some parameters are missing' do
      let(:create_params) { { shipment_amount: sample_order.shipment_amount } }

      it('returns http bad_request') { expect(response).to have_http_status(:bad_request) }
      it('returns a json error') do
        expect(response.body).to include('Validation failed')
        expect(response.body).to include('Total amount')
        expect(response.body).to include('Weight')
      end
    end
  end

  describe 'PUT #update' do
    let(:order_to_update) { create :order }
    let(:sample_order) { build :order }

    before { put :update, params: update_params, format: :json }

    context 'when order does not exist' do
      let(:update_params) { { id: 999 } }

      it('returns http not_found') { expect(response).to have_http_status(:not_found) }
    end

    context 'when all parameters are provided' do
      let(:update_params) do
        {
          id: order_to_update.id,
          shipment_amount: sample_order.shipment_amount,
          total_amount: sample_order.total_amount,
          weight: sample_order.weight
        }
      end

      it('returns http ok') { expect(response).to have_http_status(:ok) }
    end

    context 'when another parameter is provided' do
      let(:update_params) { { id: order_to_update.id, other: 'wrong parameter' } }

      it('returns http ok') { expect(response).to have_http_status(:ok) }
    end

    context 'when no parameter is provided' do
      let(:update_params) { { id: order_to_update.id } }

      it('returns http ok') { expect(response).to have_http_status(:ok) }
    end
  end

  describe 'DELETE #destroy' do
    let(:order_to_update) { create :order }
    let(:sample_order) { build :order }

    before { delete :destroy, params: delete_params, format: :json }

    context 'when order does not exist' do
      let(:delete_params) { { id: 999 } }

      it('returns http not_found') { expect(response).to have_http_status(:not_found) }
    end

    context 'when order exist' do
      let(:delete_params) { { id: order_to_update.id, other: 'wrong parameter' } }

      it('returns http no_content') { expect(response).to have_http_status(:no_content) }
    end
  end
end
