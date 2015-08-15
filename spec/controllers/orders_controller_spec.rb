require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  sign_in_user

  let(:in_progress) { create(:order, state: 'in_progress', user: @user) }
  let(:in_queue) { create(:order, state: 'in_queue', user: @user) }
  let(:in_delivery) { create(:order, state: 'in_delivery', user: @user) }
  let(:delivered) { create(:order, state: 'delivered', user: @user) }

  describe 'GET #index' do
    before { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'returns the first order with in_progress state' do
      expect(assigns(:in_progress)).to eq @user.orders.in_progress.first
    end

    it 'fills an array of orders with an in_queue state' do
      expect(assigns(:in_queue)).to match_array [in_queue]
    end

    it 'fills an array of orders with an in_delivery state' do
      expect(assigns(:in_delivery)).to match_array [in_delivery]
    end

    it 'fills an array of orders with an delivered state' do
      expect(assigns(:delivered)).to match_array [delivered]
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: delivered }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'assigns the requested order to @order' do
      expect(assigns(:order)).to eq delivered
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
