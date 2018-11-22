# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.float :shipment_amount
      t.float :total_amount
      t.integer :weight

      t.timestamps
    end
  end
end
