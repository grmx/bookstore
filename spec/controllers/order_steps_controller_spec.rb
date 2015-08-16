require 'rails_helper'

RSpec.describe OrderStepsController, type: :controller do
  sign_in_user

  let!(:order) { create(:order_with_items, user: @user) }

  describe 'GET #show' do
    pending 'Not implemented'
  end

  describe 'PATCH #update' do
    pending 'Not implemented'
  end
end
