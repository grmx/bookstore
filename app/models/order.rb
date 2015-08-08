class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :delivery

  has_many :order_items, dependent: :destroy

  validates :total_price, :state, :completed_at, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state,
    inclusion: { in: %w(in_progress in_queue in_delivery delivered canceled) }

  rails_admin do
    list do
      field :id
      field :total_price
      field :state, :state
      field :user
      field :billing_address
      field :shipping_address
      field :delivery
    end
    state({
      events: { submit: 'btn-primary', ship: 'btn-info', complete: 'btn-success'}
    })
  end

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :submit do
      transitions from: :in_progress, to: :in_queue
    end

    event :ship do
      transitions from: :in_queue, to: :in_delivery
    end

    event :complete do
      transitions from: :in_delivery, to: :delivered
    end
  end

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
