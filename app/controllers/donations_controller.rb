class DonationsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :paypal_ipn

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
      payment_method_nonce: params[:payment_method_nonce],
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      @donation = Donation.create(
        total: @cart.total,
        found: params[:checkoutSource],
        found_other: params[:checkoutSourceOtherSource],
        first_name: params[:checkoutFirstName],
        last_name: params[:checkoutLastName],
        address: params[:checkoutAddress],
        city: params[:checkoutCity],
        state: params[:checkoutState],
        zip: params[:checkoutZipCode],
        email: params[:checkoutEmail],
        newsletter: params[:checkoutNewsletter],
        payment_id: result.transaction.id,
        payment_type: result.transaction.payment_instrument_type,
        payment_status: result.transaction.status
      )

      # associate donation_items to donation and remove from cart
      @donation.donation_items << @cart.donation_items
      @cart.donation_items.delete_all
      cookies.delete :cart_count

      # update reasons with donated amounts
      @donation.finalize_donation_items

      # does user want to subscribe to newsletter?
      unless params[:checkoutNewsletter].blank?
        mailchimp = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
        begin
          mailchimp.lists.subscribe( ENV['MAILCHIMP_LIST_ID'], 
            { email: params[:checkoutEmail] },
            {
              FNAME: params[:checkoutFirstName],
              LNAME: params[:checkoutLastName]
            }, 'html', false
          )
        rescue Mailchimp::Error
          # errors >> ether
        end
      end
      # not sure if we need this now! 
      # @payment = PaymentRecord.create(
      #   donation_id: @donation.id,
      #   params: result.params
      # )
      
      # email user and admin
      DonationMailer.new_donation(@donation).deliver_now
      DonationMailer.new_donation_for_admin(@donation).deliver_now

      redirect_to thanks_path(@donation)
    else
      flash[:alert] = "There was a transaction error: %s" % result.message
      redirect_to :back
    end
  end

  # legacy IPN requests -- may use in future to update payment_status on Donations
  def paypal_ipn
    PaymentRecord.create(params: params)
    render :text => "OK"
  end

end
