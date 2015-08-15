require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    sign_in_user

    let!(:order) { create(:order_with_items, user: @user) }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'returns a current order items' do
      get :show
      expect(assigns(:order_items)).to eq order.order_items.order('created_at DESC')
    end

    it 'renders index view' do
      get :show
      expect(response).to render_template :show
    end
  end
end
