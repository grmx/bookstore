require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'association' do
    it { should have_many(:books).dependent(:destroy) }
  end
end
