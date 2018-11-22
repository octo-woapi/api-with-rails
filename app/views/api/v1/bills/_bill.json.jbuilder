# frozen_string_literal: true

if bill
  json.extract! bill,
                :amount

  # We change attributes case from snake_case to camelCase
  json.createdAt bill.created_at
  json.updatedAt bill.updated_at
end
