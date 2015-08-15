require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book_with_reviews) }

  describe 'GET #index' do
    before { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'fills an array of all books' do
      books = create_list(:book, 2)
      expect(assigns(:books)).to match_array(books)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: book }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'assigns the requested book to @book' do
      expect(assigns(:book)).to eq book
    end

    it 'assigns the book reviews to @ratings' do
      expect(assigns(:ratings)).to eq book.ratings.approved
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #wishlist' do
    sign_in_user

    before { get :wishlist }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'fills an array of all books in the wishlist' do
      @user.add_to_wishlist(create(:book))
      expect(assigns(:books)).to match_array(@user.books)
    end

    it 'renders index view' do
      expect(response).to render_template :wishlist
    end
  end

  describe 'POST #add_to_wishlist' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves a wish in the database' do
        expect { post :add_to_wishlist, id: book.id }.
          to change(@user.books, :count).by(1)
      end

      it 'assigns a success flash message' do
        post :add_to_wishlist, id: book.id
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to book show view' do
        post :add_to_wishlist, id: book.id
        expect(response).to redirect_to book_path(book)
      end
    end

    context 'with invalid attributes' do
      before do
        post :add_to_wishlist, id: book.id
      end

      it 'does not save a wish in the database' do
        expect { post :add_to_wishlist, id: book.id }.
          to_not change(@user.books, :count)
      end

      it 'assigns a danger flash message' do
        post :add_to_wishlist, id: book.id
        expect(flash[:danger]).not_to be_nil
      end

      it 'redirects to book show view' do
        post :add_to_wishlist, id: book.id
        expect(response).to redirect_to book_path(book)
      end
    end
  end

  describe 'DELETE #remove_from_wishlist' do
    sign_in_user

    before do
      @user.add_to_wishlist(book)
    end

    it 'deletes a book from Wishlist' do
      expect { delete :remove_from_wishlist, id: book }.
        to change(@user.books, :count).by(-1)
    end

    it 'assigns a warning flash message' do
      delete :remove_from_wishlist, id: book
      expect(flash[:warning]).not_to be_nil
    end

    it 'redirects to the book' do
      delete :remove_from_wishlist, id: book
      expect(response).to redirect_to book_path(book)
    end
  end
end
