require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create(:category) }

  describe 'GET #show' do
    before { get :show, id: category }

    it 'assigns the requested category to @category' do
      expect(assigns(:category)).to eq category
    end

    it 'assigns the requested @category books to @books' do
      expect(assigns(:books)).to eq category.books
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
