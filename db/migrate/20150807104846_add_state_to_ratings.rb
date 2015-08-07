class AddStateToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :state, :string, default: 'draft'
  end
end
