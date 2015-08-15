require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #about" do
    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #help" do
    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end
  end
end
