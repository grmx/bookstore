require 'rails_helper'

feature 'Update author', %q{
  In order to update the author info
  As an Administrator
  I want to be able to edit the authors
} do

  given(:admin) { create(:admin) }
  given(:user) { create(:user) }
  given(:author) { create(:author) }

  scenario 'Authorized user edits the author with valid attributes' do
    sign_in(admin)
    visit rails_admin.edit_path(model_name: 'author', id: author.id)
    within '#edit_author' do
      fill_in 'First name', with: 'Andy'
      fill_in 'Last name',  with: 'Weir'
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Author successfully updated'
    expect(find('.author_row[1] .first_name_field')).to have_content 'Andy'
    expect(find('.author_row[1] .last_name_field')).to have_content 'Weir'
  end

  scenario 'Authorized user edits the author with invalid attributes' do
    sign_in(admin)
    visit rails_admin.edit_path(model_name: 'author', id: author.id)
    within '#edit_author' do
      fill_in 'First name', with: ''
      fill_in 'Last name',  with: ''
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Author failed to be updated'
    expect(current_path).
      to eq rails_admin.edit_path(model_name: 'author', id: author.id)
  end

  scenario 'Non-authorized user tries to edit the author' do
    sign_in(user)
    visit rails_admin.edit_path(model_name: 'author', id: author.id)

    expect(current_path).to eq root_path(:en)
  end

  scenario 'Non-authenticated user tries to edit the author' do
    visit rails_admin.edit_path(model_name: 'author', id: author.id)

    expect(page).to have_css '.alert',
      text: 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
