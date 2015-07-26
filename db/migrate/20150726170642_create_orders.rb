class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 5, scale: 2
      t.string :state, default: 'in_progress'
      t.datetime :completed_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
