require 'rails_helper'

feature 'User sees best sellers', %q{
  As a visitor or a user
  I can see best sellers on the main page
} do

  given!(:books) { create_list(:book, 3) }

  scenario 'Visitor searches books on main page' do
    visit root_path
    save_and_open_page
    books.each do |book|
      expect(page).to have_content(book.title)
    end
  end
end
