require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:completed_at) }
    it do
      should validate_numericality_of(:total_price).
        is_greater_than_or_equal_to(0.01)
    end
    it do
      should validate_inclusion_of(:state).
        in_array(%w(in_progress in_queue in_delivery delivered canceled))
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:order_items).dependent(:destroy) }
  end

  describe '.add_book' do
    let(:book) { create(:book) }
    let(:order) { build(:order) }

    before { order.add_book(book) }

    it 'adds a book to the order' do
      expect(order.order_items.first.book).to eq book
    end

    it 'doesn\'t return the same book twice' do
      expect { order.add_book(book) }.to_not change { order.order_items }
    end

    it 'increments order item quantity' do
      expect { order.add_book(book) }.
        to change { order.order_items.first.quantity }.from(1).to(2)
    end
  end
end
