require 'rails_helper'

feature 'Delete author', %q{
  As an Administrator
  I want to be able to remove the author
} do

  given(:admin) { create(:admin) }
  given!(:author) { create(:author) }

  scenario 'Authorized user deletes the author from authors list' do
    sign_in(admin)
    visit rails_admin.dashboard_path
    click_on 'Authors', match: :first
    page.find(".author_row[1] .delete_member_link a").click
    click_on 'Yes, I\'m sure'
    expect(page.find('.alert')).to have_content 'Author successfully deleted'
    expect(page).to_not have_content author.first_name
  end
end
