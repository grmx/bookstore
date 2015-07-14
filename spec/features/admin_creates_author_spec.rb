require 'rails_helper'

feature 'Create author', %q{
  In order to add an author to the book
  As an Administrator
  I want to be able to create the author
} do

  scenario 'Authorized user creates an author with valid attributes' do
    author = build(:author)
    visit rails_admin.new_path(model_name: 'author')
    within '#new_author' do
      fill_in 'First name',  with: author.first_name
      fill_in 'Last name',   with: author.last_name
      fill_in 'Description', with: author.description
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Author successfully created'
    expect(find('.author_row[1] .first_name_field')).
      to have_content author.first_name
    expect(find('.author_row[1] .last_name_field')).
      to have_content author.last_name
  end

  scenario 'Authorized user creates an author with invalid attributes' do
    visit rails_admin.new_path(model_name: 'author')
    within '#new_author' do
      fill_in 'First name', with: ''
      fill_in 'Last name',  with: ''
      click_on 'Save'
    end

    expect(page.find('.alert')).to have_content 'Author failed to be created'
  end

  scenario 'Non-authorized user tries to create an author' do
    user = create(:user)
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end
    visit rails_admin.new_path(model_name: 'author')

    expect(page).to have_css '.alert', text: 'You need to sign in as administrator'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticated user tries to create an author' do
    visit rails_admin.new_path(model_name: 'author')

    expect(page).to have_css '.alert', text: 'You need to sign in or sign up'
    expect(current_path).to eq root_path
  end
end
