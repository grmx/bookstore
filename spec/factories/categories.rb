FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.sentence }

    factory :category_with_books do
      after(:create) do |category|
        create_list(:book, 3, category: category)
      end
    end
  end
end
