class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :coupon
      t.integer :discount
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
