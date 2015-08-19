require 'rails_helper'

feature 'Create book', %q{
  In order to add a book
  As an Administrator
  I want to be able to create the book
} do

  given(:user) { create(:user) }
  given(:admin) { create(:admin) }

  scenario 'Authorized user creates a book with valid attributes' do
    book = build(:book)
    sign_in(admin)
    visit rails_admin.new_path(model_name: 'book')
    within '#new_book' do
      fill_in 'Title',       with: book.title
      fill_in 'Description', with: book.description
      fill_in 'Price',       with: book.price
      fill_in 'Stock',       with: book.stock
      select book.author.full_name, from: 'Author'
      select book.category.name,    from: 'Category'
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Book successfully created'
    expect(find('.book_row[1] .title_field')).
      to have_content book.title
    expect(find('.book_row[1] .price_field')).
      to have_content book.price
  end

  scenario 'Authorized user creates a book with invalid attributes' do
    sign_in(admin)
    visit rails_admin.new_path(model_name: 'book')
    within '#new_book' do
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Book failed to be created'
    expect(current_path).to eq rails_admin.new_path(model_name: 'book')
  end

  scenario 'Non-authorized user tries to create a book' do
    sign_in(user)
    visit rails_admin.new_path(model_name: 'book')

    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to create a book' do
    visit rails_admin.new_path(model_name: 'book')

    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end

