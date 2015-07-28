require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    sign_in_user

    let(:order) { create(:order_with_items, user: @user) }

    xit 'returns a current order' do
      expect(assigns(:order)).to eq order
    end

    it 'renders index view' do
      get :show
      expect(response).to render_template :show
    end
  end
end
