class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery

  has_many :order_items, dependent: :destroy

  validates :total_price, :state, :completed_at, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state,
    inclusion: { in: %w(in_progress in_queue in_delivery delivered canceled) }

  scope :in_progress, -> { where(state: 'in_progress') }

  def add_book(book)
    current_item = self.order_items.find_or_initialize_by(book: book,
      price: book.price)
    current_item.increment(:quantity)
    current_item.save
  end

  def calc_total_price
    self.total_price = self.order_items.map do |oi|
      if oi.valid?
        oi.quantity * oi.price
      else
        nil
      end
    end.sum
  end
end
