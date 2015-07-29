require 'rails_helper'

feature 'Delete book from cart', %q{
  As a user
  I want to be able to remove a book from the shopping cart
} do

  given(:user) { create(:user) }
  given(:book) { create(:book) }
  given(:other_book) { create(:book) }

  background do
    sign_in(user)
    visit book_path(book)
    click_on 'Add to Cart'

    expect(current_path).to eq cart_path
    expect(page).to have_css '.alert',
      text: 'The book successfully added to the Cart.'
    visit book_path(other_book)
    click_on 'Add to Cart'

    expect(current_path).to eq cart_path
    expect(page).to have_content book.price + other_book.price
  end

  scenario 'Authorized user deletes the book from the Cart' do
    click_on 'book-remove', match: :first

    expect(current_path).to eq cart_path
    expect(page).to_not have_content book.title
    expect(page).to have_css '#subtotal', text: other_book.price
  end
end
