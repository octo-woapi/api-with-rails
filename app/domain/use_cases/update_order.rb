# frozen_string_literal: true

module UseCases
  class UpdateOrder
    class << self
      def with_products!(order, params)
        order.update!(status: params[:status], order_products_attributes: order_params(params))
      end

      private

      def order_params(params)
        params[:products].map do |product|
          {
            product_id: product[:id],
            quantity: product[:quantity]
          }
        end
      end
    end
  end
end
