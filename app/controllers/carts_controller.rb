class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_order
  end
end
