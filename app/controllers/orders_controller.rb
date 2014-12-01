class OrdersController < ApplicationController

  def create
    result = Braintree::Transaction.sale(
              amount: @cart.total,
              payment_method_nonce: params[:payment_method_nonce])

    # todo: store payment_transaction regardless of status?
    if result.success?
      @order = Order.create(
        cart: @cart,
        first_name: params[:checkoutFirstName],
        last_name: params[:checkoutLastName],
        zip: params[:checkoutLastName],
        email: params[:checkoutEmail],
        payment_type: result.transaction.payment_instrument_type,
        payment_status: result.transaction.status
      )
      # @payment = PaymentRecord.create(
      #   order_id: @order.id,
      #   params: result.params
      # )
      redirect_to thanks_path(@order)
    else
      flash[:alert] = "There was a transaction error: %s" % result.message
      redirect_to :back
    end
  end

end
