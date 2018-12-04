# frozen_string_literal: true

require 'rails_helper'

describe 'GET /v1/products', type: :request do
  before do
    FactoryBot.create_list(:product, 10)

    get '/api/v1/products'
  end

  it 'returns HTTP status 200' do
    expect(response).to have_http_status 200
  end

  it 'returns all products' do
    body = JSON.parse(response.body)
    expect(body.size).to eq(10)
  end
end
