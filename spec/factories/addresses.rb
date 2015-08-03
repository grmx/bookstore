FactoryGirl.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    zipcode "12345"
    city { Faker::Address.city }
    phone "1234567890"
    country "United States"
  end

end
