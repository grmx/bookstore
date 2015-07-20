class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(9)
  end
end
