# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      before_action :find_product, only: %i[show update destroy]

      def index
        @products = Product.sort(params[:sort])
      end

      def show; end

      def create
        @product = Product.create!(product_params)
        render 'show', status: :created, location: api_v1_product_url(@product)
      end

      def update
        @product.update!(product_params)
        render 'show'
      end

      def destroy
        @product.destroy!
      end

      private

      def find_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.permit(%i[name price weight])
      end
    end
  end
end
