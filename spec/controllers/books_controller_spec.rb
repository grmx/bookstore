require 'rails_helper'

RSpec.describe BooksController, type: :controller do
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
end
