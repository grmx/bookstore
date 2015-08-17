module OrderStepsHelper

  private

  def validate_step
    jump_to(previous_step.to_sym) if session[previous_step.to_sym].nil?
  end
end
