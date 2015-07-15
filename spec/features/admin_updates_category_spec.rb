require 'rails_helper'

feature 'Update category', %q{
  In order to edit the category name
  As an Administrator
  I want to be able to update categories into admin panel
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }
  given(:category) { create(:category) }

  scenario 'Authorized user edits the category name with valid attributes' do
    sign_in(admin)
    visit rails_admin.edit_path(model_name: 'category', id: category.id)
    within '#edit_category' do
      fill_in 'Name', with: 'New name'
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Category successfully updated'
    expect(find('.category_row[1] .name_field')).to have_content 'New name'
  end

  scenario 'Authorized user edits the category name with invalid attributes' do
    sign_in(admin)
    visit rails_admin.edit_path(model_name: 'category', id: category.id)
    within '#edit_category' do
      fill_in 'Name', with: ''
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Category failed to be updated'
    expect(current_path).
      to eq rails_admin.edit_path(model_name: 'category', id: category.id)
  end

  scenario 'Non-authorized user tries to edit the category' do
    sign_in(user)
    visit rails_admin.edit_path(model_name: 'category', id: category.id)

    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to edit the category' do
    visit rails_admin.edit_path(model_name: 'category', id: category.id)

    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
