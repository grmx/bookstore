require 'rails_helper'

feature 'Navigate by categories', %q{
  In order to be able to view the books by a category
  As a visitor or a user
  I want to be able to choice the book category
} do

  let!(:categories) { create_list(:category_with_books, 2) }

  scenario 'Visitor searches books by categories' do
    visit root_path

    categories.each do |category|
      expect(page).to have_css 'a', text: category.name
    end

    click_on categories.last.name

    expect(page).to have_css 'h2', text: categories.last.name
    categories.last.books.each do |book|
      expect(page).to have_css 'a', text: book.title
    end

    click_on categories.first.name

    expect(page).to have_css 'h2', text: categories.first.name
    categories.first.books.each do |book|
      expect(page).to have_css 'a', text: book.title
    end
  end
end
