class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order_items = current_order.order_items.order('created_at DESC')
  end
end
