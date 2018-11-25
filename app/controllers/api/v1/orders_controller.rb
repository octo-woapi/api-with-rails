# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApiController
      before_action :find_order, only: %i[show update destroy]

      def index
        @orders = Order.order(created_at: :desc)
      end

      def show; end

      def create
        @order = UseCases::CreateOrder.with_products!(create_params)
        render 'show', status: :created, location: api_v1_order_url(@order)
      end

      def update
        @order = UseCases::UpdateOrder.with_products!(@order, update_params)
        render 'show'
      end

      def destroy
        @order.destroy!
      end

      private

      def find_order
        @order = Order.find(params[:id])
      end

      def create_params
        params.permit(products: %i[id quantity])
      end

      def update_params
        params.permit(:id, :status, products: %i[id quantity])
      end
    end
  end
end
