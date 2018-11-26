class AddOrderReferenceToBill < ActiveRecord::Migration[5.1]
  def change
    add_reference :bills, :order, foreign_key: true
  end
end
