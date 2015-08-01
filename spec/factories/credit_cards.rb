FactoryGirl.define do
  factory :credit_card do
    number { Faker::Business.credit_card_number.remove('-') }
    exp_month 2
    exp_year 2048
    cvv { Faker::Number.number(3) }
    user
  end
end
