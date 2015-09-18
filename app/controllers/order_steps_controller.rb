class OrderStepsController < ApplicationController
  before_action :authenticate_user!
  before_action :build_form

  include OrderStepsHelper
  include Wicked::Wizard

  steps :billing_address, :shipping_address, :delivery, :payment, :confirm,
        :complete

  def show
    validate_step
    render_wizard
  end

  def update
    @form.update(step, order_steps_params)
    session[step] = true
    render_wizard @form
  end

  private

  def build_form
    @form = CheckoutForm.new(current_order)
  end

  def order_steps_params
    params.permit(address: [:first_name, :last_name, :address, :city, :country,
                            :zipcode, :phone],
                  credit_card: [:number, :exp_month, :exp_year, :cvv],
                  delivery: :id)
  end
end
