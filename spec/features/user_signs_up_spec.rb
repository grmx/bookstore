require 'rails_helper'

feature 'User sign up', %q{
  In order to be able to use the Bookstore service
  As a visitor
  I want to be able to sign up
} do

  given(:user) { build(:user) }

  scenario 'Visitor registers successfully via register form' do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email',      with: user.email
      fill_in 'Password',   with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation
      click_on 'Sign up'
    end

    expect(page).to_not have_content 'Sign up'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Visitor registers unsuccessful via register form' do
    visit new_user_registration_path
    within '#new_user' do
      click_on 'Sign up'
    end

    expect(page).to_not have_content 'Sign out'
    expect(page).to have_content 'Sign up'
    expect(page).to have_css 'div .alert'
  end
end
