FactoryGirl.define do
  factory :identity do
    provider "facebook"
    uid "12345678"
    user
  end
end
