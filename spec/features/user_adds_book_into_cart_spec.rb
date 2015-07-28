require 'rails_helper'

feature 'Add book into cart', %q{
  In order to be able to buy the books
  As a user
  I want to be able to add a book into the shopping cart
} do

  given(:user) { create(:user) }
  given!(:book) { create(:book) }

  scenario 'Authorized user adds the book to the Cart' do
    sign_in(user)
    visit book_path(book)
    click_on 'Add to Cart'
    expect(page).to have_css '.alert',
      text: 'The book successfully added to the Cart.'
  end

  scenario 'Authorized user adds the book to the Cart twice' do
    sign_in(user)
    visit book_path(book)
    click_on 'Add to Cart'
    expect(page).to have_content book.price
    visit book_path(book)
    click_on 'Add to Cart'
    expect(page).to have_content(book.price * 2)
  end

  scenario 'Visitor adds the book to the Cart' do
    visit book_path(book)
    click_on 'Add to Cart'
    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Sign in'
  end
end
