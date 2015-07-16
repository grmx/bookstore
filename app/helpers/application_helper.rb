module ApplicationHelper

  private

  def sidebar_categories
    @categories ||= Category.all
  end
end
