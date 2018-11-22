# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

      def record_invalid(error)
        render body: { error: error.message }.to_json, status: :bad_request
      end
    end
  end
end
