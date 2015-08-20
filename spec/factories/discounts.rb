FactoryGirl.define do
  factory :discount do
    name "Halloween Discount"
    coupon "HALLOWEEN2015"
    discount 20
    expires_at "2015-10-31 00:00"
  end

end
