module ApplicationHelper

  private

  def cart_counter
    if current_user.orders.in_progress.present?
      current_user.orders.in_progress.last.order_items.count
    else
      '0'
    end
  end

  def sidebar_categories
    Category.all
  end
end
