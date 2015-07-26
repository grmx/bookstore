FactoryGirl.define do
  factory :order do
    total_price "9.99"
    state "in_progress"
    user
    completed_at Time.now
  end
end
