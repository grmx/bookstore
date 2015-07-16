require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  let(:category) { create(:category_with_books) }
  let(:book) { category.books.first }

  before do
    assign(:category, category)
    render
  end

  it 'has a category name' do
    expect(rendered).to have_css 'h2', text: category.name
  end

  it 'has a book title' do
    expect(rendered).to have_css 'a', text: book.title
  end

  it 'has a book price' do
    expect(rendered).to have_content book.price
  end
end
