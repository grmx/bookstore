class CreateBooksUsers < ActiveRecord::Migration
  def change
    create_table :books_users, id: false do |t|
      t.references :book
      t.references :user

      t.timestamps null: false
    end
    add_index :books_users, [:book_id, :user_id], unique: true
  end
end
