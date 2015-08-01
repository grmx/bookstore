require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:exp_month) }
    it { should validate_presence_of(:exp_year) }
    it { should validate_presence_of(:cvv) }
    it { should validate_length_of(:number).is_equal_to(16) }
    it { should validate_length_of(:exp_month).is_at_most(2) }
    it { should validate_length_of(:exp_year).is_equal_to(4) }
    it { should validate_length_of(:cvv).is_equal_to(3) }
  end

  describe 'association' do
    it { should belong_to(:user) }
  end
end
