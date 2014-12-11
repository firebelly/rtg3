class OrdersController < ApplicationController

  def create
    if @cart.total == 0
      flash[:alert] = "You have nothing in your cart."
      return redirect_to :back
    elsif params[:payment_method_nonce].blank?
      flash[:alert] = "There was a transaction error. Please try again."
      return redirect_to :back
    end

    result = Braintree::Transaction.sale(
              amount: @cart.total,
              payment_method_nonce: params[:payment_method_nonce])

    if result.success?
      @order = Order.create(
        cart: @cart,
        total: @cart.total,
        found: params[:checkoutSource],
        found_other: params[:checkoutSourceOtherSource],
        first_name: params[:checkoutFirstName],
        last_name: params[:checkoutLastName],
        zip: params[:zip_code],
        email: params[:checkoutEmail],
        payment_type: result.transaction.payment_instrument_type,
        payment_status: result.transaction.status
      )
      # user wants to subscribe to newsletter?
      unless params[:checkoutNewsletter].blank?
        mailchimp = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
        mailchimp.lists.subscribe( ENV['MAILCHIMP_LIST_ID'], 
          { email: params[:checkoutEmail] },
          {
            FNAME: params[:checkoutFirstName],
            LNAME: params[:checkoutLastName]
          }, 'html', false
        )
      end
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
