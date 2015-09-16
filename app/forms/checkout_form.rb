class CheckoutForm
  include ActiveModel::Model

  def initialize(order)
    @order = order
  end

  def update(step, params)
    case step
    when :billing_address
      if @order.billing_address
        @order.billing_address.assign_attributes(params[:address])
      else
        @order.create_billing_address(params[:address])
      end
    when :shipping_address
      if @order.shipping_address
        @order.shipping_address.assign_attributes(params[:address])
      else
        @order.create_shipping_address(params[:address])
      end
    when :delivery
      @order.delivery = Delivery.find(params[:delivery][:id])
    when :payment
      if @order.user.credit_card
        @order.user.credit_card.assign_attributes(params[:credit_card])
      else
        @order.user.create_credit_card(params[:credit_card])
      end
    when :confirm
      @order.state = :in_queue
      @order.completed_at = Time.zone.now
      OrderNotifier.received(@order).deliver_now
    when :complete
    end
  end

  def save
    @order.save
  end

  def billing_address
    build_address(:billing)
  end

  def shipping_address
    build_address(:shipping)
  end

  def deliveries
    Delivery.order(:price)
  end

  def payment
    @order.user.credit_card || CreditCard.new
  end

  private

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
