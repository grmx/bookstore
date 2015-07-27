class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items, dependent: :destroy

  validates :total_price, :state, :completed_at, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state,
    inclusion: { in: %w(in_progress in_queue in_delivery delivered canceled) }
end
