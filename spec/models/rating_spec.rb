require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:review) }
    it { should validate_presence_of(:rating) }
    it { should validate_numericality_of(:rating).only_integer }
    it { should validate_inclusion_of(:rating).in_range(1..10) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end
