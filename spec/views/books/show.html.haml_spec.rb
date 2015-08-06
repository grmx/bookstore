require 'rails_helper'

RSpec.describe "books/show", type: :view do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:ratings) { create_list(:rating, 2, book: book, user: user)}
  before do
    assign(:book, book)
    assign(:ratings, ratings)
    render
  end

  it 'has a book title' do
    expect(rendered).to have_css 'h3', text: book.title
  end

  it 'has a book cover' do
    expect(rendered).to have_css "img[src$='cover.jpg']"
  end

  it 'has a book price' do
    expect(rendered).to have_content book.price
  end

  it 'has a book description' do
    expect(rendered).to have_content book.description
  end

  it 'has a book author' do
    expect(rendered).to have_content book.author.full_name
  end

  it 'has a "Add to Cart" button' do
    expect(rendered).to have_button 'Add to Cart'
  end
end
