require 'rails_helper'

feature 'User signs in with Facebook', %q{
  As a user
  I want to sign in with Facebook
} do

  given!(:identity) { create(:identity) }

  scenario 'User can sign in with valid account' do
    sign_in_facebook
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  scenario 'User cannot sign in with invalid account' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Facebook'
    click_link 'Sign in with Facebook'
    expect(page).to have_content 'Could not authenticate you from Facebook because "Invalid credentials"'
  end

end
