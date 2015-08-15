require 'rails_helper'

feature 'Upload cover', %q{
  In order to add a book cover
  As an Administrator
  I want to be able to attach an image
} do

  given!(:admin) { create(:admin) }
  given!(:book) { create(:book) }

  scenario 'Administrator adds a book cover' do
    sign_in(admin)
    visit rails_admin.edit_path(model_name: 'book', id: book.id)
    attach_file 'Cover', "#{Rails.root}/spec/support/uploads/cover.jpg"
    click_on 'Save'

    expect(page).to have_content 'Book successfully updated'
    visit book_path(book)
    expect(page).to have_css "img[src$='cover.jpg']"
    visit books_path
    expect(page).to have_css "img[src$='thumb_cover.jpg']"
  end

end
