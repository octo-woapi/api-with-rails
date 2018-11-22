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
        @product = Product.create!(product_params)
        render 'show', status: :created, location: api_v1_product_url(@product)
      end

      def update
        @product = Product.find(params[:id])
        @product.update!(product_params)
        render 'show'
      end

      private

      def product_params
        params.permit(%i[name price weight])
      end
    end
  end
end
