require 'rails_helper'

feature 'View best sellers', %q{
  As a visitor or a user
  I want to see best sellers on the main page
} do

  given!(:orders) { create_list(:order_with_items, 3) }

  background do
    @bestsellers_array = OrderItem.bestsellers.map!(&:book_id)
    @books = Book.find(@bestsellers_array)
  end

  scenario 'Visitor searches bestsellers on main page' do
    visit root_path
    expect(page).to have_content 'Bestsellers'
    @books.each do |book|
      expect(page).to have_content book.title
    end
  end
end
