class CategoriesController < ApplicationController
  def show
    @category = Category.includes(:books).find(params[:id])
  end
end
