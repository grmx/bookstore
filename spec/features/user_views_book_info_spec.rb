require 'rails_helper'

feature 'View book info', %q{
  As a visitor or a user
  I want to view detailed information about a book on a book page
} do

  given!(:book) { create(:book) }

  scenario 'Visitor views a book page' do
    visit books_path(:en)
    click_on book.title

    expect(current_path).to eq book_path(:en, book)
    expect(page).to have_content book.title
    expect(page).to have_content book.price
    expect(page).to have_content book.description
    expect(page).to have_content book.author.full_name
  end
end
