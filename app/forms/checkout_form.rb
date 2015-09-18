class CheckoutForm
  include ActiveModel::Model

  def initialize(order)
    @order = order
  end

  def update(step, params)
    case step
    when :billing_address
      save_billing_address(params[:address])
    when :shipping_address
      save_shipping_address(params[:address])
    when :delivery
      @order.delivery = Delivery.find(params[:delivery][:id])
    when :payment
      save_payment_settings(params[:credit_card])
    when :confirm
      order_confirmation
    end
  end

  def save_billing_address(address)
    if @order.billing_address
      @order.billing_address.assign_attributes(address)
    else
      @order.create_billing_address(address)
    end
  end

  def save_shipping_address(address)
    if @order.shipping_address
      @order.shipping_address.assign_attributes(address)
    else
      @order.create_shipping_address(address)
    end
  end

  def save_payment_settings(credit_card)
    if @order.user.credit_card
      @order.user.credit_card.assign_attributes(credit_card)
    else
      @order.user.create_credit_card(credit_card)
    end
  end

  def order_confirmation
    @order.state = :in_queue
    @order.completed_at = Time.zone.now
    OrderNotifier.received(@order).deliver_now
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
end
