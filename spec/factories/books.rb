FactoryGirl.define do
  factory :book do
    title { Faker::Lorem.sentence(2) }
    description { Faker::Lorem.paragraph }
    price "9.99"
    stock 17
    author
  end
end
