class RatingsController < ApplicationController
  load_and_authorize_resource only: :create

  def create
    book = Book.find(params[:book_id])
    create_user_rating_for(book)
    redirect_to book_url(book)
  end

  private

  def create_user_rating_for(book)
    rating = book.ratings.create(rating_params)
    rating.user = current_user
    if rating.save
      flash[:success] = 'Thanks! Your review is awaiting moderation.'
    else
      flash[:danger] = 'Review can\'t be blank.'
    end
  end

  def rating_params
    params.require(:rating).permit(:rating, :review)
  end
end
