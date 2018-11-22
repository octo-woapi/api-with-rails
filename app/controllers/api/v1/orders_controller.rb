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
        @order = Order.create!(order_params)
        render 'show', status: :created, location: api_v1_order_url(@order)
      end

      def update
        @order.update!(order_params)
        render 'show'
      end

      def destroy
        @order.destroy!
      end

      private

      def find_order
        @order = Order.find(params[:id])
      end

      def order_params
        params.permit(%i[shipment_amount total_amount weight])
      end
    end
  end
end
