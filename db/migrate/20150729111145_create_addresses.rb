class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :zipcode, limit: 5
      t.string :city
      t.string :phone, limit: 12
      t.string :country

      t.timestamps null: false
    end
  end
end
