class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
