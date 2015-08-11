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
end
