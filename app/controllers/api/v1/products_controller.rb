# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      respond_to :json

      def index
        @products = Product.order(created_at: :desc)
      end
    end
  end
end
