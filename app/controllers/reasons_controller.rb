class ReasonsController < ApplicationController

  before_filter :set_defaults

  def index
  	@page = Page.friendly.find('give')
  	@promoted_reason = Reason.published.unfulfilled.promoted.limit(1)
  	@reasons = Reason.published.unfulfilled - @promoted_reason
  end

  def show
    @reason = Reason.friendly.find(params[:id])
    @og_description = @reason.excerpt || @reason.content
    @og_image = view_context.image_url(@reason.image.url(:thumb)) unless @reason.image.blank?
  end

  def thanks
    @order = Order.find(params[:order_id])
    @reasons = Reason.where(id: @order.cart.donations.select(:reason_id))
    @general_donation = @order.cart.donations.where(reason_id: nil).first
  end

  private

  def set_defaults
    @body_class = 'reason'
  end

end
