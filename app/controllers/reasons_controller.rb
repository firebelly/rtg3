class ReasonsController < ApplicationController

  before_filter :set_defaults

  def index
    @page = Page.friendly.find('give')
    @promoted_reason = Reason.published.unfulfilled.promoted.limit(1)
    @reasons = Reason.published.unfulfilled - @promoted_reason
  end

  def success_stories
    @page = Page.friendly.find('success-stories')
    @promoted_success = Reason.published.is_success.promoted.limit(1)
    @successes = Reason.published.is_success - @promoted_success
    render 'reasons/success_stories'
  end

  def success_story
    @reason = Reason.friendly.find(params[:id])
    @slider_reasons = Reason.published.is_success.where('id != ?', @reason.id)
    @og_description = @reason.success_excerpt || @reason.content
    @og_image = view_context.image_url(@reason.image.url(:thumb)) unless @reason.image.blank?
    render 'reasons/show'
  end

  def show
    @reason = Reason.friendly.find(params[:id])
    @slider_reasons = Reason.published.unfulfilled.where('id != ?', @reason.id)
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
