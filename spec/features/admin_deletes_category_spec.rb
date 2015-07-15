require 'rails_helper'

feature 'Delete category', %q{
  As an Administrator
  I want to be able to remove the category
} do

  given(:admin) { create(:admin) }
  given!(:category) { create(:category) }

  scenario 'Authorized user deletes the category from a categories list' do
    sign_in(admin)
    visit rails_admin.dashboard_path
    click_on 'Categories', match: :first
    page.find(".category_row[1] .delete_member_link a").click
    click_on 'Yes, I\'m sure'

    expect(page.find('.alert')).to have_content 'Category successfully deleted'
    expect(page).to_not have_content category.name
  end
end
