require 'rails_helper'

feature 'Create category', %q{
  In order to add a category to the book
  As an Administrator
  I want to be able to create categories into admin panel
} do

  given(:user) { create(:user) }
  given(:admin) { create(:admin) }

  scenario 'Authorized user creates a category with valid attributes' do
    category = build(:category)
    sign_in(admin)
    visit rails_admin.new_path(model_name: 'category')
    within '#new_category' do
      fill_in 'Name',  with: category.name
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Category successfully created'
    expect(find('.category_row[1] .name_field')).
      to have_content category.name
  end

  scenario 'Authorized user creates a category with invalid attributes' do
    sign_in(admin)
    visit rails_admin.new_path(model_name: 'category')
    within '#new_category' do
      fill_in 'Name', with: ''
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Category failed to be created'
    expect(current_path).to eq rails_admin.new_path(model_name: 'category')
  end

  scenario 'Non-authorized user tries to create a category' do
    sign_in(user)
    visit rails_admin.new_path(model_name: 'category')

    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to create a category' do
    visit rails_admin.new_path(model_name: 'category')

    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
