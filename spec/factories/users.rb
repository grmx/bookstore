FactoryGirl.define do
  factory :user do
    email { Faker::Internet::email }
    password 'password42'
    password_confirmation 'password42'
  end
end
