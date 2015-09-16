module OrderStepsHelper

  def last_order
    current_user.orders.in_queue.last
  end

  private

  def validate_step
    if session[previous_step.to_sym].nil? && step != steps.first
      jump_to(previous_step.to_sym)
    elsif step.eql? steps.last
      steps.each { |s| session.delete(s) }
    end
  end
end
