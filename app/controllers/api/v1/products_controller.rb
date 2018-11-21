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
    end
  end
end
