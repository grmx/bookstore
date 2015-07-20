class BooksController < ApplicationController
  def index
    @books = Book.order(:title).page(params[:page]).per(9)
  end

  def show
    @book = Book.find(params[:id])
  end
end
