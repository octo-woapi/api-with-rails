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
    context 'when products are provided' do
      let(:create_params) do
        {
          'products' => [{
            'id' => '1',
            'quantity' => '3'
          }]
        }
      end
      let(:returned_order) { create :order }

      before do
        allow(UseCases::CreateOrder).to receive(:with_products!).and_return(returned_order)
        post :create, params: create_params, format: :json
      end

      it 'calls use case' do
        expect(UseCases::CreateOrder).to have_received(:with_products!).with(create_params)
      end

      it('returns http created') { expect(response).to have_http_status(:created) }
      it('returns header location') { expect(response.headers['Location']).not_to be_blank }
    end

    context 'when products is empty' do
      let(:create_params) do
        {
          'products' => []
        }
      end

      before do
        allow(UseCases::CreateOrder).to receive(:with_products!)
        post :create, params: create_params, format: :json
      end

      it('does not call use case') { expect(UseCases::CreateOrder).not_to have_received(:with_products!) }
      it('returns http bad_request') { expect(response).to have_http_status(:bad_request) }
      it('returns a json error') do
        expect(response.body).to include('The following attributes are missing')
        expect(response.body).to include('products')
      end
    end
  end

  describe 'PUT #update' do
    let(:order_to_update) { create :order }

    context 'when order does not exist' do
      let(:update_params) { { id: 999 } }

      before { put :update, params: update_params, format: :json }

      it('returns http not_found') { expect(response).to have_http_status(:not_found) }
    end

    context 'when all parameters are provided' do
      let(:update_params) do
        {
          'id' => order_to_update.id.to_s,
          'products' => [{
            'id' => '1',
            'quantity' => '3'
          }],
          'status' => 'paid'
        }
      end
      let(:returned_order) { create :order }

      before do
        allow(UseCases::UpdateOrder).to receive(:with_products!).and_return(returned_order)
        put :update, params: update_params, format: :json
      end

      it 'calls use case' do
        expect(UseCases::UpdateOrder).to have_received(:with_products!).with(order_to_update, update_params)
      end

      it('returns http ok') { expect(response).to have_http_status(:ok) }
    end

    context 'when products does not contain id key' do
      let(:update_params) do
        {
          'id' => order_to_update.id.to_s,
          'products' => [
            'quantity' => '2'
          ]
        }
      end

      before do
        allow(UseCases::UpdateOrder).to receive(:with_products!)
          .and_raise(ActiveRecord::RecordInvalid.new, 'product must exist')
        put :update, params: update_params, format: :json
      end

      it('calls use case') { expect(UseCases::UpdateOrder).to have_received(:with_products!) }
      it('returns http bad_request') { expect(response).to have_http_status(:bad_request) }
      it('returns a json error') { expect(response.body).to include('product must exist') }
    end

    context 'when products is empty and quantity is missing' do
      let(:update_params) do
        {
          'id' => order_to_update.id.to_s,
          'products' => []
        }
      end

      before do
        allow(UseCases::UpdateOrder).to receive(:with_products!)
        put :update, params: update_params, format: :json
      end

      it('does not call use case') { expect(UseCases::UpdateOrder).not_to have_received(:with_products!) }
      it('returns http bad_request') { expect(response).to have_http_status(:bad_request) }
      it('returns a json error') do
        expect(response.body).to include('The following attributes are missing: status, products')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:order_to_update) { create :order }

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
