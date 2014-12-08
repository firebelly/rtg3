class CartsController < ApplicationController

  def show
  end

  def add
    donation = @cart.donations.where(reason_id: params[:reason_id]).first
    if donation
      donation.update(amount: donation.amount + params[:amount].to_f)
    else
      donation = Donation.new(
        amount: params[:amount].gsub('$','').to_f,
        reason_id: params[:reason_id]
        )
      @cart.donations << donation
    end
    render partial: 'carts/show'
  end
  
  def update
    donation = Donation.find(params[:donation_id])
    if donation
      donation.update(amount: params[:amount].to_f)
    end
    render partial: 'carts/show'
  end
  
  def remove
    donation = Donation.find(params[:donation_id])
    @cart.donations.delete(donation)
    render text: @cart.donations.count, status: 200
  end

  def count
    render text: @cart.count, status: 200
  end

  def total
    render text: @cart.total, status: 200
  end

end
