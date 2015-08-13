require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:stock) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:category) }
    it do
      should validate_numericality_of(:price).
        is_greater_than_or_equal_to(0.01)
    end
  end

  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:category) }
    it { should have_many(:ratings).dependent(:destroy) }
    it { should have_and_belong_to_many(:users) }
  end

  describe '.search(keyword)' do
    let!(:book) { create(:book) }

    it 'returns a book by keyword' do
      expect(Book.search(book.title)).to match_array([book])
    end
  end
end
