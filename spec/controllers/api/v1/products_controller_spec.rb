# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #index' do
    subject { get :index, format: :json }

    context 'when there is no product' do
      it('returns http success') { expect(response).to have_http_status(:success) }
    end

    context 'when there are some products' do
      before { create_list :product, 2 }

      it('returns http success') { expect(response).to have_http_status(:success) }
    end
  end
end
