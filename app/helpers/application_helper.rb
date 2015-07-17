module ApplicationHelper

  private

  def sidebar_categories
    Category.all
  end
end
