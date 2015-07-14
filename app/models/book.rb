class Book < ActiveRecord::Base
  belongs_to :author

  validates :title, :price, :stock, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
