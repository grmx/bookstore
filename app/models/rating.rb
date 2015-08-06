class Rating < ActiveRecord::Base
  validates :review, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..10 }

  belongs_to :book
  belongs_to :user
end
