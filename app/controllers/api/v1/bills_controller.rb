# frozen_string_literal: true

module Api
  module V1
    class BillsController < ApiController
      def index
        @bills = Bill.order(created_at: :desc)
      end

      def show
        @bill = Bill.find(params[:id])
      end
    end
  end
end
