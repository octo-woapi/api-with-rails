# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'associations' do
    subject(:bill) { build :bill }

    it { expect(bill).to belong_to :order }
  end

  describe 'validations' do
    subject(:bill) { build :bill }

    it { expect(bill).to validate_presence_of :amount }
  end
end
