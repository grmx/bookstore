require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:order) { create(:order_with_items) }

  describe '#sidebar_categories' do
    it 'returns all categories' do
      categories = create_list(:category, 5)
      expect(sidebar_categories).to eq categories
    end
  end

  describe '#full_title' do
    it 'returns a full title with arg' do
      expect(full_title('Page name')).to eq 'Bookstore · Page name'
    end

    it 'returns a shop name' do
      expect(full_title('')).to eq 'Bookstore'
    end
  end

  describe '#cart_counter' do
    it 'doesnt display unless an order exists' do
      allow(helper).to receive(:current_order).and_return(nil)
      expect(helper.cart_counter).to eq nil
    end

    it 'returns an order counter' do
      allow(helper).to receive(:current_order).and_return(order)
      expect(helper.cart_counter).to eq order.order_items.count
    end
  end

  describe '#order_total_price' do
    it 'doesnt display if cart is empty' do
      order_blank = create(:order)
      allow(helper).to receive(:current_order).and_return(order_blank)
      expect(helper.order_total_price).to eq nil
    end

    it 'returns an order counter' do
      allow(helper).to receive(:current_order).and_return(order)
      expect(helper.order_total_price).to eq "$#{order.total_price}"
    end
  end

  describe '#sidebar_categories' do
    let(:categories) { create_list(:category, 3) }

    it 'returns categories' do
      expect(sidebar_categories).to eq categories
    end
  end
end
