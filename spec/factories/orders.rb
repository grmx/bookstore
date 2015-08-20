FactoryGirl.define do
  factory :order do
    total_price "9.99"
    state "in_progress"
    user
    delivery
    completed_at Time.now
    discount nil

    factory :order_with_items do
      after(:create) do |order|
        create_list(:order_item, 3, order: order)
      end
    end

    trait :random_state do
      state { %w(in_progress in_queue in_delivery delivered canceled).sample }
    end

    factory :order_with_random_state, traits: [:random_state]
  end
end
