require 'rails_helper'

feature 'Upload avatar', %q{
  As a user
  I want to be able to upload avatar
} do

  given!(:user) { create(:user) }

  background do
    sign_in(user)
    visit edit_user_registration_path
    fill_in 'Current password', with: user.password
  end

  scenario 'User adds an avatar ' do
    attach_file 'Avatar', "#{Rails.root}/spec/support/uploads/avatar.jpg"
    click_on 'Update'

    expect(page).to have_content 'Your account has been updated successfully'
    visit edit_user_registration_path
    expect(page).to have_css "img[src$='avatar.jpg']"
  end

  scenario 'User changes an avatar' do
    attach_file 'Avatar', "#{Rails.root}/spec/support/uploads/avatar_new.jpg"
    click_on 'Update'

    expect(page).to have_content 'Your account has been updated successfully'
    visit edit_user_registration_path
    expect(page).to have_css "img[src$='avatar_new.jpg']"
  end

end
