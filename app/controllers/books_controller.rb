class BooksController < ApplicationController
  def index
    @books = if params[:search]
      Book.search(params[:search]).order(:title).page(params[:page]).per(9)
    else
      Book.order(:title).page(params[:page]).per(9)
    end
  end

  def show
    @book = Book.find(params[:id])
    @rating = Rating.new
    @ratings = @book.ratings
  end
end
