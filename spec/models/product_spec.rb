# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it do
      is_expected.to validate_presence_of :name
      is_expected.to validate_presence_of :price
      is_expected.to validate_presence_of :weight
    end
  end
end
