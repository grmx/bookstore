require 'rails_helper'

feature 'User paces order', %q{
  In order to buy books from the shopping cart
  As a user
  I want to be able to place an order with books
} do

  given(:user) { create(:user) }
  given!(:book) { create(:book) }
  given(:address) { create(:address) }
  given(:cc) { create(:credit_card) }
  given!(:deliveries) { create_list(:delivery, 3) }

  before do
    sign_in(user)
    visit book_path(book)
    click_on 'Add to Cart'
    click_on 'Checkout'
  end

  scenario 'A user fills in a checkout form' do
    expect(page).to have_css 'h4', text: 'Step 1'
    expect(page).to have_css 'h3', text: 'Billing Address'
    expect(page).to have_content book.price

    fill_in 'First name',     with: address.first_name
    fill_in 'Last name',      with: address.last_name
    fill_in 'Street address', with: address.address
    fill_in 'City',           with: address.city
    fill_in 'Country',        with: address.country
    fill_in 'Zipcode',        with: address.zipcode
    fill_in 'Phone',          with: address.phone
    click_on 'Save and continue'

    expect(page).to have_css 'h4', text: 'Step 2'
    expect(page).to have_css 'h3', text: 'Shipping Address'
    expect(page).to have_content book.price

    fill_in 'First name',     with: address.first_name
    fill_in 'Last name',      with: address.last_name
    fill_in 'Street address', with: address.address
    fill_in 'City',           with: address.city
    fill_in 'Country',        with: address.country
    fill_in 'Zipcode',        with: address.zipcode
    fill_in 'Phone',          with: address.phone
    click_on 'Save and continue'

    expect(page).to have_css 'h4', text: 'Step 3'
    expect(page).to have_css 'h3', text: 'Delivery'
    expect(page).to have_content book.price + deliveries.first.price

    click_on 'Save and continue'

    expect(page).to have_css 'h4', text: 'Step 4'
    expect(page).to have_css 'h3', text: 'Credit card'
    expect(page).to have_content book.price + deliveries.first.price

    fill_in 'Number',    with: cc.number
    select cc.exp_month, from: 'credit_card_exp_month'
    select cc.exp_year,  from: 'credit_card_exp_year'
    fill_in 'Card Code', with: cc.cvv
    click_on 'Save and continue'

    expect(page).to have_css 'h4', text: 'Step 5'
    expect(page).to have_css 'h3', text: 'Confirm'
    expect(page).to have_content book.title
    expect(page).to have_content book.price
    expect(page).to have_content book.price + deliveries.first.price

    click_on 'Place Order'

    expect(page).to_not have_css 'h4', text: 'Step 6'
    expect(page).to_not have_css 'h3', text: 'Complete'
    expect(page).to have_content book.title
    expect(page).to have_content book.price
    expect(page).to have_content book.price + deliveries.first.price

    click_on 'Go back to Store'

    expect(current_path).to eq root_path
  end
end
