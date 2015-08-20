require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:state) }
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
    it { should belong_to(:billing_address).class_name('Address') }
    it { should belong_to(:shipping_address).class_name('Address') }
    it { should belong_to(:delivery) }
    it { should belong_to(:discount) }
  end

  describe 'additional methods' do
    let(:book) { create(:book) }
    let(:order) { build(:order) }
    let(:user) { create(:user) }
    let!(:orders) { create_list(:order_with_random_state, 8, user: user) }

    before { order.add_book(book) }

    describe '.in_progress' do

      it 'doesn\'t return all orders'  do
        expect(user.orders.in_progress).to_not match_array(orders)
      end

      it 'returns orders in progress' do
        expect(user.orders.in_progress).
          to match_array(user.orders.where(state: 'in_progress'))
      end
    end

    describe '.in_queue' do
      it 'doesn\'t return all orders'  do
        expect(user.orders.in_queue).to_not match_array(orders)
      end

      it 'returns orders in queue' do
        expect(user.orders.in_queue).
          to match_array(user.orders.where(state: 'in_queue'))
      end
    end

    describe '.in_delivery' do
      it 'doesn\'t return all orders'  do
        expect(user.orders.in_delivery).to_not match_array(orders)
      end

      it 'returns orders in delivery' do
        expect(user.orders.in_delivery).
          to match_array(user.orders.where(state: 'in_delivery'))
      end
    end

    describe '.delivered' do
      it 'doesn\'t return all orders'  do
        expect(user.orders.delivered).to_not match_array(orders)
      end

      it 'returns delivered order' do
        expect(user.orders.delivered).
          to match_array(user.orders.where(state: 'delivered'))
      end
    end

    describe '.add_book' do
      it 'adds a book to the order' do
        expect(order.order_items.first.book).to eq book
      end

      it 'doesn\'t return the same book twice' do
        expect { order.add_book(book) }.to_not change { order.order_items }
      end

      it 'changes order item quantity' do
        expect { order.add_book(book) }.
          to change { order.order_items.first.quantity }.from(1).to(2)
      end
    end

    describe '.calc_total_price' do
      it 'returns total price for an order item' do
        expect(order.calc_total_price).to eq book.price
      end

      it 'returns total price for several order items' do
        order.add_book(book)
        expect { order.calc_total_price }.
          to change { order.total_price }.from(book.price).to(book.price * 2)
      end
    end
  end
end
