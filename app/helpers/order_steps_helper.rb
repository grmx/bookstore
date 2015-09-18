module OrderStepsHelper
  def last_order
    current_user.orders.in_queue.last
  end

  private

  def validate_step
    jump_to(previous_step.to_sym) if wrong_step?
    steps.each { |s| session.delete(s) } if step.eql?(steps.last)
  end

  def wrong_step?
    session[previous_step.to_sym].nil? && step != steps.first
  end
end
