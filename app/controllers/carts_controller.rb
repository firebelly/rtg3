class CartsController < ApplicationController

  def show
  end

  def add
    donation_item = @cart.donation_items.where(reason_id: params[:reason_id]).first
    amount = params[:amount].gsub(/[^\d\.]/,'').to_f
    if donation_item
      donation_item.update(amount: donation_item.amount + amount)
    else
      donation_item = DonationItem.new(
        amount: amount,
        reason_id: params[:reason_id]
        )
      @cart.donation_items << donation_item
    end
    render partial: 'carts/show'
  end
  
  def update
    donation_item = DonationItem.find(params[:donation_item_id])
    amount = params[:amount].gsub(/[^\d\.]/,'').to_f
    if donation_item
      donation_item.update(amount: amount)
    end
    render partial: 'carts/show'
  end
  
  def remove
    donation_item = DonationItem.find(params[:donation_item_id])
    @cart.donation_items.delete(donation_item)
    render text: @cart.donation_items.count, status: 200
  end

  def count
    render text: @cart.count, status: 200
  end

  def total
    render text: @cart.total, status: 200
  end

end
