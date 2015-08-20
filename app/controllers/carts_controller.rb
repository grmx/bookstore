class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_order
    @order_items = current_order.order_items.order('created_at DESC')
  end

  def update
    discount = Discount.find_by(coupon: params[:discount])
    order = current_order
    if order.order_items.update(params[:order_items].keys,
                                params[:order_items].values)
      order.discount = discount
      order.calc_total_price
      order.save
      flash[:success] = 'The Cart successfully updated.'
      redirect_to cart_path
    end
  end
end
