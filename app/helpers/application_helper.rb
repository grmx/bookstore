module ApplicationHelper
  private

  def full_title(page_title)
    base_title = 'Bookstore'
    if page_title.empty?
      "#{base_title}"
    else
      "#{base_title} · #{page_title}"
    end
  end

  def cart_counter
    current_order.order_items.count if current_order
  end

  def order_total_price
    number_to_currency current_order.calc_total_price if cart_counter > 0
  end

  def sidebar_categories
    Category.all
  end
end
