FactoryGirl.define do
  factory :book do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price "9.99"
    stock 17
    category
    author
    cover { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/cover.jpg", 'image/jpeg') }

    factory :book_with_reviews do
      after(:create) do |book|
        create_list(:rating, 3, book: book)
      end
    end
  end
end
