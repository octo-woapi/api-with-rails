# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.float :amount

      t.timestamps
    end
  end
end
