require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:book) { create(:book) }

  sign_in_user

  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability).and_return(@ability)
    @ability.can :manage, OrderItem, user: @user
    request.env['HTTP_REFERER'] = cart_path
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves an order_item in the database' do
        expect { post :create, book_id: book.id }.
          to change(OrderItem, :count).by(1)
      end

      it 'assigns a success flash message' do
        post :create, book_id: book.id
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to root_path' do
        post :create, book_id: book.id
        expect(response).to redirect_to cart_path
      end
    end

    context 'with invalid attributes' do
      it 'generates RecordNotFound error without post params' do
        expect { post :create, book_id: 'abcd' }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT #update' do
    let!(:order) { create(:order, user: @user) }
    let!(:order_item) { create(:order_item, order: order) }

    it 'updates order items quantity' do
      expect { put :update, id: order_item.id, order_item: { quantity: 2 } }.
        to change{order.order_items.first.quantity}.from(1).to(2)
    end

    it 'assigns an info flash message' do
      put :update, id: order_item.id, order_item: { quantity: 2 }
      expect(flash[:info]).not_to be_nil
    end

    it 'redirects to the cart' do
      put :update, id: order_item.id, order_item: { quantity: 2 }
      expect(response).to redirect_to cart_path
    end
  end

  describe 'DELETE #destroy' do
    let(:order) { create(:order, user: @user) }
    let!(:order_item) { create(:order_item, order: order) }

    it 'deletes an order item' do
      expect { delete :destroy, id: order_item }.
        to change(OrderItem, :count).by(-1)
    end

    it 'assigns a warning flash message' do
      delete :destroy, id: order_item
      expect(flash[:warning]).not_to be_nil
    end

    it 'redirects to the cart' do
      delete :destroy, id: order_item
      expect(response).to redirect_to cart_path
    end
  end
end
