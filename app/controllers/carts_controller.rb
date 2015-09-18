class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_order
    @order_items = current_order.order_items.order('created_at DESC')
  end

  def update
    discount = Discount.find_by(coupon: params[:discount])
    order_update(current_order, discount)
    flash[:success] = 'The Cart successfully updated.'
    redirect_to cart_path
  end

  def destroy
    current_order.empty!
    flash[:warning] = 'The Cart successfully emptied.'
    redirect_to cart_path
  end

  private

  def order_update(order, discount)
    order.order_items.update(params[:order_items].keys, params[:order_items]
      .values)
    order.discount = discount
    order.calc_total_price
    order.save
  end
end
