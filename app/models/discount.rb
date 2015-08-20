class Discount < ActiveRecord::Base
  validates :name, :coupon, :discount, :expires_at, presence: true
  validates :coupon, uniqueness: { case_sensitive: false }
end
