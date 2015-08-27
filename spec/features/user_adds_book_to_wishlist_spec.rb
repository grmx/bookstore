require 'rails_helper'

feature 'User adds book to wishlist', %q{
  In order to buy books later
  As a user
  I want to be able to place a book into wishlist
} do

  given(:user) { create(:user) }
  given(:book) { create(:book) }

  scenario 'Authorized user adds a book to the wish list' do
    sign_in(user)
    visit book_path(:en, book)
    click_on 'Wishlist'

    expect(page).to have_css '.alert',
      text: 'The book successfully added to Wishlist'

    visit wishlist_books_path(:en)

    expect(page).to have_content book.title
    expect(page).to have_content book.price
  end
end
