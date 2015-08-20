class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery
  belongs_to :discount

  has_many :order_items, dependent: :destroy

  validates :total_price, :state, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state,
    inclusion: { in: %w(in_progress in_queue in_delivery delivered canceled) }

  rails_admin do
    list do
      field :state, :state
      include_all_fields
      exclude_fields :completed_at, :updated_at
    end
    state({
      events: { submit: 'btn-primary', ship: 'btn-info', complete: 'btn-success', 
        cancel: 'btn-danger' }
    })
  end

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :submit, before: :complete_order do
      transitions from: :in_progress, to: :in_queue
    end

    event :ship, before: :complete_order  do
      transitions from: :in_queue, to: :in_delivery
    end

    event :complete, before: :complete_order  do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel, before: :complete_order  do
      transitions from: [:in_progress, :in_queue], to: :canceled
    end
  end

  def add_book(book)
    current_item = self.order_items.find_or_initialize_by(book: book,
      price: book.price)
    current_item.increment(:quantity)
    current_item.save
  end

  def calc_total_price
    self.total_price = self.order_items.map { |oi| oi.valid? ? oi.quantity * oi.price : nil }.sum
  end

  def calc_discount
    total_price - total_price * (discount.discount / 100.0) if discount
  end

  private

  def complete_order
    self.completed_at = Time.current
  end
end
