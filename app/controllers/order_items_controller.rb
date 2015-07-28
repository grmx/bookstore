class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    order = current_order
    order.add_book(book)
    order.completed_at = Time.now
    order.calc_total_price
    if order.save
      flash[:success] = 'The book successfully added to the Cart.'
      session[:order_id] = order.id
      redirect_to cart_path
    else
      flash.now[:danger] = 'We have some problems.'
      redirect_to :back
    end
  end
end
