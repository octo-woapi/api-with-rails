# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      def index
        @products = Product.order(created_at: :desc)
      end

      def show
        @product = Product.find(params[:id])
      end

      def create
        @product = Product.create!(create_params)
        render 'show', status: :created, location: api_v1_product_url(@product)
      rescue ActiveRecord::RecordInvalid => error
        render body: { error: error.message }.to_json, status: :bad_request
      end

      private

      def create_params
        params.permit(%i[name price weight])
      end
    end
  end
end
