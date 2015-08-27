require 'rails_helper'

feature 'User review', %q{
  As a user
  I want to be able to post a review for a book
} do

  given(:user) { create(:user) }
  given(:book) { create(:book) }
  given(:review) { create(:rating, user: user, book: book) }

  scenario 'Authorized user creates a review' do
    sign_in(user)
    visit book_path(:en, book)
    fill_in 'Review', with: review.review
    choose review.rating
    click_on 'Add review'

    expect(current_path).to eq book_path(:en, book)
    expect(page).not_to have_content review.review
    expect(page).to have_css '.alert', 
      text: 'Thanks! Your review is awaiting moderation'
  end
end
