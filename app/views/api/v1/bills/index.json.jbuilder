# frozen_string_literal: true

json.array! @bills, partial: 'api/v1/bills/bill', as: :bill
