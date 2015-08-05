require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    sign_in_user

    before { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    xit 'fills a variable of in_progress first order' do
      in_progress = create(:order, state: 'in_progress')
      expect(assigns(:in_progress)).to eq in_progress
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
