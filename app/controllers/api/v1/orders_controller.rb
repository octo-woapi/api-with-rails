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
        raise_bad_request_for_attributes!(%i[products]) unless create_params[:products].present?
        @order = UseCases::CreateOrder.with_products!(create_params)
        render 'show', status: :created, location: api_v1_order_url(@order)
      end

      def update
        raise_bad_request_for_attributes!(%i[status products]) if status_and_products_missing?
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

      def status_and_products_missing?
        !update_params[:status].present? && !update_params[:products].present?
      end

      def raise_bad_request_for_attributes!(attributes)
        error_message = "The following attributes are missing: #{attributes.map(&:to_s).join(', ')}"
        raise(ActionController::BadRequest.new, error_message)
      end
    end
  end
end
