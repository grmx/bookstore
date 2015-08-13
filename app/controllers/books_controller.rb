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
    @ratings = @book.ratings.approved
  end

  def wishlist
    @books = current_user.books.page(params[:page]).per(9)
  end

  def add_to_wishlist
    book = Book.find(params[:id])
    unless current_user.book_in_wishlist?(book)
      current_user.add_to_wishlist(book)
      flash[:success] = "The book successfully added to Wishlist"
      redirect_to book_path(book)
    else
      flash[:danger] = "The book already in Wishlist"
      redirect_to book_path(book)
    end
  end

  def remove_from_wishlist
    book = Book.find(params[:id])
    if current_user.book_in_wishlist?(book)
      current_user.remove_from_wishlist(book)
      flash[:warning] = "The book successfully removed from Wishlist"
      redirect_to book_path(book)
    else
      flash[:danger] = "We have some problems"
      redirect_to book_path(book)
    end
  end
end
