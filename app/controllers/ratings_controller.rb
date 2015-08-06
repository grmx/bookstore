class RatingsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    rating = book.ratings.create(rating_params)
    rating.user = current_user
    if rating.save
      flash[:success] = "Thanks! Your review is awaiting moderation."
      redirect_to :back
    else
      flash[:danger] = "Review can't be blank."
      redirect_to book
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
