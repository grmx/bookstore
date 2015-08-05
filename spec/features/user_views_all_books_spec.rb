require 'rails_helper'

feature 'View all books', %q{
  As a visitor or a user
  I want to see all books in bookstore
} do

  given!(:books) { create_list(:book, 3) }

  scenario 'Visitor searches books on books_path' do
    visit books_path

    expect(page).to have_content 'All books'
    books.each do |book|
      expect(page).to have_css 'a', text: book.title
      expect(page).to have_content book.price
    end
  end
end
