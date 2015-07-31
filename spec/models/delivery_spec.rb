require 'rails_helper'

RSpec.describe Delivery, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it do
      should validate_numericality_of(:price).
        is_greater_than_or_equal_to(0.01)
    end
  end
end
