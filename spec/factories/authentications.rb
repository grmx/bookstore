FactoryGirl.define do
  factory :authentication do
    provider "Facebook"
    uid "123456"
    user
  end
end
