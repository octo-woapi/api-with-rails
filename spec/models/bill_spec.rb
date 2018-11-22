# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'validations' do
    subject(:bill) { build :bill }

    it do
      expect(bill).to validate_presence_of :amount
    end
  end
end
