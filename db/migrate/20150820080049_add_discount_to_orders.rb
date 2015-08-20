class AddDiscountToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :discount, index: true, foreign_key: true
  end
end
