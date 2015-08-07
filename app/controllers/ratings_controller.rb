class RatingsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    rating = book.ratings.create(rating_params)
    rating.user = current_user
    if rating.save
      flash[:success] = "Thanks! Your review is awaiting moderation."
    else
      flash[:danger] = "Review can't be blank."
    end
    redirect_to book_url(book)
    authorize! :create, rating
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
