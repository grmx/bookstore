class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    orders = current_user.orders
    @in_progress = orders.in_progress.first
    @in_queue = orders.in_queue
    @in_delivery = orders.in_delivery
    @delivered = orders.delivered
  end

  def show
    @order = Order.find(params[:id])
    authorize! :show, @order
  end
end
