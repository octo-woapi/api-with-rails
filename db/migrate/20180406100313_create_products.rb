# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :weight

      t.timestamps
    end
  end
end
