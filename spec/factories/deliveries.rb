FactoryGirl.define do
  factory :delivery do
    name { Faker::Lorem.sentence }
    price "9.99"
  end
end
