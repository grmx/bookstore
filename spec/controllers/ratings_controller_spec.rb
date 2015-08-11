require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:book) { create(:book) }

  sign_in_user

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new review in the database' do
        expect { post :create, book_id: book.id, 
          rating: attributes_for(:rating) }.to change(Rating, :count).by(1)
      end

      it 'assigns a success flash message' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to book show view' do
        post :create, book_id: book.id, rating: attributes_for(:rating)
        expect(response).to redirect_to book_path(book)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the review' do
        expect { post :create, book_id: book.id, rating: attributes_for(:rating, 
          review: '') }.to_not change(Rating, :count)
      end

      it 'assigns a danger flash message' do
        post :create, book_id: book.id, rating: attributes_for(:rating, review: '')
        expect(flash[:danger]).not_to be_nil
      end

      it 'redirects to the book' do
        post :create, book_id: book.id, rating: attributes_for(:rating, review: '')
        expect(response).to redirect_to book_path(book)
      end
    end
  end
end
