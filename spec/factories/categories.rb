FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.sentence }
  end
end
