class OrderNotifier < ApplicationMailer
  def received(order)
    @order = order

    mail to: order.user.email, subject: 'Bookstore Order Confirmation'
  end

  def shipped(order)
    @order = order

    mail to: order.user.email, subject: 'Bookstore Order Shipped'
  end
end
