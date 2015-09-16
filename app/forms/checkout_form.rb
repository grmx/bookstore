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
      @order.completed_at = Time.current
      OrderNotifier.received(@order).deliver_now
    when :complete
    end
  end

  def save
    @order.save
  end

  def billing_address
    @order.billing_address || Address.new
  end

  def shipping_address
    @order.shipping_address || Address.new
  end

  def deliveries
    Delivery.order(:price)
  end

  def payment
    @order.user.credit_card || CreditCard.new
  end

  def complete
    @order = current_user.orders.in_queue.first
    @order.total_price = @order.calc_discount if @order.discount
    @shipping_address = @order.shipping_address
    @billing_address = @order.billing_address
    [:billing_address, :shipping_address, :delivery, :payment, :confirm].
      each { |s| session.delete(s) }
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
