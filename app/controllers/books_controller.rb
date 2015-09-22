class BooksController < ApplicationController
  def index
    @books = params[:search] ? search_collection : books_collection
  end

  def bestsellers
    redirect_to root_url(locale: params[:set_locale]) if params[:set_locale]
    @bestsellers_id = OrderItem.bestsellers.map!(&:book_id)
    @bestsellers = Book.find(@bestsellers_id)
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
    if current_user.book_in_wishlist?(book)
      flash[:danger] = 'The book already in Wishlist'
    else
      current_user.add_to_wishlist(book)
      flash[:success] = 'The book successfully added to Wishlist'
    end
    redirect_to book_path(book)
  end

  def remove_from_wishlist
    book = Book.find(params[:id])
    if current_user.book_in_wishlist?(book)
      current_user.remove_from_wishlist(book)
      flash[:warning] = 'The book successfully removed from Wishlist'
    else
      flash[:danger] = 'We have some problems'
    end
    redirect_to book_path(book)
  end

  private

  def search_collection
    Book.search(params[:search]).order(:title).page(params[:page]).per(9)
  end

  def books_collection
    Book.order(:title).page(params[:page]).per(9)
  end
end
