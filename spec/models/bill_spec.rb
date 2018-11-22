# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'validations' do
    it do
      is_expected.to validate_presence_of :amount
    end
  end
end
