class OrderStepsController < ApplicationController
  before_filter :authenticate_user!

  include OrderStepsHelper
  include Wicked::Wizard

  steps :billing_address, :shipping_address, :delivery, :payment, :confirm, :complete

  def show
    @order = current_order
    case step
    when :billing_address
      @billing_address = build_address(:billing)
    when :shipping_address
      validate_step
      @shipping_address = build_address(:shipping)
    when :delivery
      validate_step
      @deliveries = Delivery.order(:price)
      @order.delivery ||= @deliveries.first
    when :payment
      validate_step
      @credit_card = current_user.credit_card || current_user.build_credit_card
    when :confirm
      validate_step
      @shipping_address = @order.shipping_address
      @billing_address = @order.billing_address
    when :complete
      validate_step
      @order = current_user.orders.in_queue.first
      @order.total_price = @order.calc_discount if @order.discount
      @shipping_address = @order.shipping_address
      @billing_address = @order.billing_address
      [:billing_address, :shipping_address, :delivery, :payment, :confirm].
        each { |s| session.delete(s) }
    end
    render_wizard
  end

  def update
    @order = current_order
    case step
    when :billing_address
      @billing_address = @order.billing_address || @order.build_billing_address(address_params)
      save_step(:billing_address)
    when :shipping_address
      @shipping_address = @order.shipping_address || @order.build_shipping_address(address_params)
      save_step(:shipping_address)
    when :delivery
      @order.delivery = Delivery.find(params[:order][:delivery_id])
      session[:delivery] = true
      render_wizard @order
    when :payment
      @credit_card = current_user.create_credit_card(credit_card_params)
      save_step(:credit_card)
    when :confirm
      @order.state = :in_queue
      @order.completed_at = Time.current
      OrderNotifier.received(@order).deliver_now
      session[:confirm] = true
      render_wizard @order
    when :complete
      render_wizard @order
    end
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address,
      :city, :country, :zipcode, :phone)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :exp_month, :exp_year, :cvv)
  end

  def build_address(type)
    @order.send("#{type}_address") || Address.new
  end

  def save_step(object)
    if instance_variable_get("@#{object}").save
      session[step.to_sym] = true
      render_wizard @order
    else
      render_wizard
    end
  end
end
