class CreditCard < ActiveRecord::Base
  belongs_to :user

  validates :number, :exp_month, :exp_year, :cvv, presence: true
  validates :number, length: { is: 16 }
  validates :exp_month, length: { maximum: 2 }
  validates :exp_year, length: { is: 4 }
  validates :cvv, length: { is: 3 }

  def last_digits
    number.slice(-4..-1)
  end

  def mask
    "**** **** **** #{last_digits}"
  end

  def date
    "#{exp_month}/#{exp_year}"
  end
end
