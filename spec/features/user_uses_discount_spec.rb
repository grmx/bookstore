require 'rails_helper'

feature 'User discount', %q{
  In order to buy books with discount
  As a user
  I can use discount coupon
} do

  given(:user) { create(:user) }
  given!(:book) { create(:book) }
  given!(:discount) { create(:discount) }

  background do
    sign_in(user)
    visit book_path(book)
    click_on 'Add to Cart'
    visit cart_path
    fill_in 'Coupon code', with: discount.coupon
    click_on 'Update cart'
  end

  scenario 'Authorized user uses a discount coupon' do
    expect(current_path).to eq cart_path
    expect(page).
      to have_content (book.price - (book.price * discount.discount / 100)).round(2)
  end

  scenario 'Authorized user changes a book quantity' do
    fill_in 'qnty', with: '2'
    click_on 'Update cart'

    expect(page).
      to have_content (book.price - (book.price * discount.discount / 100)).round(2) * 2
  end

end
