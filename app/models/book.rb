class Book < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  belongs_to :author
  belongs_to :category

  validates :title, :price, :stock, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
