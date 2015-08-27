require 'rails_helper'

feature 'User search', %q{
  As a visitor or a user
  I want to search for books by keyword
} do

  given!(:book) { create(:book, title: 'The Martian') }
  given!(:other_book) { create(:book) }

  scenario 'User searches for books by keyword' do
    visit root_path(:en)
    fill_in 'search', with: 'Martian'
    click_on 'Search'

    expect(current_path).to eq books_path(:en)
    expect(page).to have_css 'h2', text: 'Search'
    expect(page).to have_content book.title
    expect(page).to have_content book.price
    expect(page).to_not have_content other_book.title
  end
end

