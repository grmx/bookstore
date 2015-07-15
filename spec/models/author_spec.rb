require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'association' do
    it { should have_many(:books).dependent(:destroy) }
  end

  describe '#full_name' do
    it 'returns full author\'s name' do
      author = create(:author)
      expect(author.full_name).to eq "#{author.first_name} #{author.last_name}"
    end
  end
end
