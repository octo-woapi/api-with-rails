# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it do
      is_expected.to validate_presence_of :shipment_amount
      is_expected.to validate_presence_of :total_amount
      is_expected.to validate_presence_of :weight
    end
  end
end
