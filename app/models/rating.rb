class Rating < ActiveRecord::Base
  include AASM

  validates :review, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..10 }

  belongs_to :book
  belongs_to :user

  rails_admin do
    list do
      field :state, :state
      field :book
      field :review
      field :user
    end
    state({ states: { approved: 'label-success', rejected: 'label-warning' } })
  end

  aasm column: 'state' do
    state :draft
    state :approved
    state :rejected

    event :approve do
      transitions from: :draft, to: :approved 
    end

    event :reject do
      transitions from: :draft, to: :rejected
    end
  end
end
