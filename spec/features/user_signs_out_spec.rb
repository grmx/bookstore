require 'rails_helper'

feature 'User sign out', %q{
  As a signed in user
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Registered user tries to sign out' do
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path

    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end
