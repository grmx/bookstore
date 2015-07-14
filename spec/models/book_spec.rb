require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:stock) }
    it do
      should validate_numericality_of(:price).
        is_greater_than_or_equal_to(0.01)
    end
  end

  describe 'associations' do
    it { should belong_to(:author) }
  end
end
