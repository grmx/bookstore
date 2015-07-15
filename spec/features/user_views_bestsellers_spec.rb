require 'rails_helper'

feature 'View best sellers', %q{
  As a visitor or a user
  I want to see best sellers on the main page
} do

  given!(:books) { create_list(:book, 3) }

  scenario 'Visitor searches books on main page' do
    visit root_path
    books.each do |book|
      expect(page).to have_content(book.title)
    end
  end
end
