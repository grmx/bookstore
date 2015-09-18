class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: [:update, :destroy]

  def create
    book = Book.find(params[:book_id])
    order = current_order
    order.add_book(book)
    order.calc_total_price
    if order.save
      flash[:success] = 'The book successfully added to the Cart.'
    else
      flash.now[:danger] = 'We have some problems.'
    end
    redirect_to cart_path
  end

  def update
    @order_item.update(order_item_params)
    @order_item.order.calc_total_price
    if @order_item.order.save
      flash[:info] = 'The Cart successfully updated.'
    else
      flash.now[:warning] = 'Sorry, this book is not present in stock.'
    end
    redirect_to cart_path
  end

  def destroy
    @order_item.destroy
    order = @order_item.order
    order.calc_total_price
    order.save
    flash[:warning] = 'The book successfully removed from shopping cart.'
    redirect_to cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:id, :quantity)
  end
end
