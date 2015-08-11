class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    order = current_order
    order.add_book(book)
    order.calc_total_price
    if order.save
      flash[:success] = 'The book successfully added to the Cart.'
      redirect_to cart_path
    else
      flash.now[:danger] = 'We have some problems.'
      redirect_to :back
    end
  end

  def update
    order_item = OrderItem.find(params[:id])
    authorize! :update, order_item
    order_item.update(quantity: params[:order_item][:quantity])
    order_item.order.calc_total_price
    if order_item.order.save
      flash[:info] = "The Cart successfully updated."
      redirect_to cart_path
    else
      flash.now[:warning] = "Sorry, this book is not present in stock."
      redirect_to cart_path
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    authorize! :delete, order_item
    order_item.destroy
    order = order_item.order
    order.calc_total_price
    order.save
    flash[:warning] = 'The book successfully removed from shopping cart.'
    redirect_to cart_path
  end
end
