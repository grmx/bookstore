require 'rails_helper'

RSpec.describe "books/index", type: :view do
  let(:books) { create_list(:book, 5) }

  before do
    allow(view).to receive_messages(paginate: nil)
    assign(:books, books)
    render
  end

  it 'has a "All books" title' do
    expect(rendered).to have_content 'All books'
  end

  it 'renders a list of books' do
    expect(rendered).to have_css 'h4 a', count: 5
  end

  it 'renders a price of books' do
    expect(rendered).to have_css 'p.price', count: 5
  end
end
