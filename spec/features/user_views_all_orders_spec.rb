require 'rails_helper'

feature 'View all orders', %q{
  In order to view history of all my purchases
  As a user
  I want to be able views all orders by state
  } do

  given(:user) { create(:user) }
  given!(:in_progress) { create(:order_with_items, state: 'in_progress', 
    user: user) }
  given!(:in_queue) { create(:order, state: 'in_queue', user: user) }
  given!(:in_delivery) { create(:order, state: 'in_delivery', user: user) }
  given!(:delivered) { create(:order, state: 'delivered', user: user) }
  given(:other_order) { create(:order) }

  scenario 'Authorized user views all orders' do
    sign_in(user)
    visit root_path
    click_on 'My orders'

    expect(current_path).to eq orders_path
    expect(page).to have_css 'h2', text: 'Orders'
    expect(page).to have_content 'In Progress'
    in_progress.order_items.each do |oi|
      expect(page).to have_css 'a', text: oi.book.title
      expect(page).to have_content oi.book.price
    end

    expect(page).to have_content 'Waiting for Processing'
    expect(page).to have_content in_queue.id
    expect(page).to have_content in_queue.completed_at
    expect(page).to have_content in_queue.total_price

    expect(page).to have_content 'In Delivery'
    expect(page).to have_content in_delivery.id
    expect(page).to have_content in_delivery.completed_at
    expect(page).to have_content in_delivery.total_price

    expect(page).to have_content 'Delivered'
    expect(page).to have_content delivered.id
    expect(page).to have_content delivered.completed_at
    expect(page).to have_content delivered.total_price
  end

  scenario 'Authorized user views a single order page' do
    sign_in(user)
    visit order_path(delivered)

    expect(page).to have_css 'h2', text: "Order #{delivered.id}"
    delivered.order_items.each do |oi|
      expect(page).to have_css 'a', text: oi.book.title
      expect(page).to have_content oi.book.price
    end
    expect(page).to have_content delivered.total_price
    expect(page).to have_content delivered.total_price + delivered.delivery.price
  end

  xscenario 'User tries to view foreign order' do
    sign_in(user)
    visit order_path(other)

    expect(page).to have_css '.alert',
      text: 'You are not authorized to access this page.'
    expect(current_path).to eq root_path
  end

  scenario 'Visitor tries to view all orders' do
    visit orders_path

    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Sign in'
  end

  scenario 'Visitor tries to view a single order' do
    visit order_path(delivered)

    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Sign in'
  end
end
