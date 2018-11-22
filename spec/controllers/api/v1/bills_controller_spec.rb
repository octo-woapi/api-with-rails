# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BillsController, type: :controller do
  describe 'GET #index' do
    context 'when there is no bill' do
      before { get :index, format: :json }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end

    context 'when there are some bills' do
      before do
        create_list :bill, 2
        get :index, format: :json
      end

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: bill_id }, format: :json }

    context 'when bill ID does not exist' do
      let(:bill_id) { 999 }

      it('returns http not_found') { expect(response).to have_http_status(:not_found) }
    end

    context 'when bill ID exists' do
      let(:bill) { create :bill }
      let(:bill_id) { bill.id }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end
end
