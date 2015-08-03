class OrderStepsController < ApplicationController
  before_filter :authenticate_user!

  include Wicked::Wizard
  steps :billing_address, :shipping_address, :delivery, :payment, :confirm, :complete

  def show
    @order = current_order
    case step
    when :billing_address
      @billing_address = @order.billing_address || Address.new
    when :shipping_address
      @shipping_address = @order.shipping_address || Address.new
    when :delivery
      @deliveries = Delivery.order(:price)
      @order.delivery ||= @deliveries.first
    when :payment
      @credit_card = current_user.credit_card || current_user.build_credit_card
    when :confirm
      @shipping_address = @order.shipping_address
      @billing_address = @order.billing_address
    when :complete
      @order = current_user.orders.in_queue.first
      @shipping_address = @order.shipping_address
      @billing_address = @order.billing_address
    end
    render_wizard
  end

  def update
    @order = current_order
    case step
    when :billing_address
      @billing_address = @order.billing_address || Address.create(address_params)
      if @billing_address.save
        @order.billing_address = @billing_address
        render_wizard @order
      else
        render_wizard
      end
    when :shipping_address
      @shipping_address = @order.shipping_address || Address.create(address_params)
      if @shipping_address.save
        @order.shipping_address = @shipping_address
        render_wizard @order
      else
        render_wizard
      end
    when :delivery
      @order.delivery = Delivery.find(params[:order][:delivery_id])
      render_wizard @order
    when :payment
      @credit_card = current_user.create_credit_card(credit_card_params)
      if @credit_card.save
        render_wizard @order
      else
        render_wizard
      end
    when :confirm
      @order.state = :in_queue
      @order.completed_at = Time.now
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
end
