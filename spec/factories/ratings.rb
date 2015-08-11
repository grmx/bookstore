FactoryGirl.define do
  factory :rating do
    review "MyText"
    rating 10
    book
    user
  end
end
