# frozen_string_literal: true

module UseCases
  class CreateOrder
    class << self
      def with_products!(order)
        Order.create!(order_products_attributes: order_params(order))
      end

      private

      def order_params(order)
        order[:products].map do |product|
          {
            product_id: product[:id],
            quantity: product[:quantity]
          }
        end
      end
    end
  end
end
