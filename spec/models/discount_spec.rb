require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:coupon) }
    it { should validate_presence_of(:discount) }
    it { should validate_presence_of(:expires_at) }
    it { should validate_uniqueness_of(:coupon).case_insensitive }
  end
end
