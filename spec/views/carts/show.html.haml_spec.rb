require 'rails_helper'

RSpec.describe "carts/show", type: :view do
  let(:order) { create(:order_with_items) }
  let(:book) { order.order_items.first.book }

  before do
    assign(:order, order)
    assign(:order_items, order.order_items)
    render
  end

  it 'has a book cover' do
    expect(rendered).to have_css "img[src$='#{book.cover.thumb}']"
  end

  it 'has a book title' do
    expect(rendered).to have_content book.title
  end

  it 'has a book price' do
    expect(rendered).to have_content book.price
  end

  it 'has total price' do
    expect(rendered).to have_content order.total_price
  end
end
