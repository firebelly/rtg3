class ReasonsController < ApplicationController

  before_filter :set_defaults

  def index
    @page = Page.friendly.find('give')
    @promoted_reason = Reason.published.not_success.promoted.limit(1)
    @reasons = Reason.published.not_success - @promoted_reason
  end

  def success_stories
    @body_class = 'success-stories'
    @page = Page.friendly.find('success-stories')
    @promoted_success = Reason.published.is_success.promoted.limit(1)
    @successes = Reason.published.is_success - @promoted_success
    render 'reasons/success_stories'
  end

  def success_story
    @body_class = 'success-stories'
    @reason = Reason.friendly.find(params[:id])
    @slider_reasons = Reason.published.is_success.where('id != ?', @reason.id)
    @og_description = @reason.success_excerpt || @reason.content
    @og_image = view_context.image_url(@reason.image.url(:thumb)) unless @reason.image.blank?
    # has the title changed? redirect to new URL
    if request.path != success_story_path(@reason)
      redirect_to success_story_path(@reason), status: :moved_permanently
    else
      render 'reasons/show'
    end
  end

  def show
    @reason = Reason.friendly.find(params[:id])
    @slider_reasons = Reason.published.not_success.where('id != ?', @reason.id)
    @og_description = @reason.excerpt || @reason.content
    @og_image = view_context.image_url(@reason.image.url(:thumb)) unless @reason.image.blank?
    
    if @reason.is_success?
      # is this now a success? redirect to proper URL
      redirect_to success_story_path(@reason), status: :moved_permanently
    elsif request.path != reason_path(@reason)
      # maybe the title has just changed, redirect to proper URL
      redirect_to @reason, status: :moved_permanently
    end
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
