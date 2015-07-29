require 'rails_helper'

feature 'Navigate by pages', %q{
  In order to be able to view the books on the next page
  As a visitor or a user
  I want to be able to navigate by pages
} do

  let!(:category) { create(:category_with_books, books_count: 10) }

  scenario 'Visitor navigates by pages (all books)' do
    visit books_path

    expect(page).to have_selector 'h4', count: 9
    expect(page).to have_css 'li.active a', text: '1'
    expect(page).to have_css 'li a', text: '2'

    click_on 'Next'

    expect(page).to have_selector 'h4', count: 1
    expect(page).to have_css 'li.active a', text: '2'
    expect(page).to have_css 'li a', text: '1'
  end

  scenario 'Visitor navigates by pages (books by category)' do
    visit category_path(category)

    expect(page).to have_selector 'h4', count: 9
    expect(page).to have_css 'li.active a', text: '1'
    expect(page).to have_css 'li a', text: '2'

    click_on 'Next'

    expect(page).to have_selector 'h4', count: 1
    expect(page).to have_css 'li.active a', text: '2'
    expect(page).to have_css 'a', text: '1'
  end
end
