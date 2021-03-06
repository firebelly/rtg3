class ReasonsController < ApplicationController

  before_filter :set_defaults

  def index
    @page = Page.friendly.find('give')
    @promoted_reason = Reason.published.unfulfilled.promoted.limit(1)
    if @promoted_reason.empty?
      @promoted_reason = Reason.published.unfulfilled.limit(1)
    end
    @reasons = Reason.published.unfulfilled - @promoted_reason
    if @reasons.length < 2
      @body_class += ' one-reason'
    end
  end

  def success_stories
    @body_class = 'success-stories'
    @page = Page.friendly.find('success-stories')
    @promoted_success = Reason.published.is_success.promoted.limit(1)
    if @promoted_success.empty?
      @promoted_success = Reason.published.is_success.limit(1)
    end
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
    
    if @reason.is_success? and @reason.fulfilled?
      # is this now a success? redirect to proper URL
      redirect_to success_story_path(@reason), status: :moved_permanently
    elsif request.path != reason_path(@reason)
      # maybe the title has just changed, redirect to proper URL
      redirect_to @reason, status: :moved_permanently
    end
  end

  def thanks
    @donation = Donation.find(params[:donation_id])
    @reasons = Reason.where(id: @donation.donation_items.select(:reason_id))
    @general_donation = @donation.donation_items.where(reason_id: nil).first
  end

  private

  def set_defaults
    @body_class = 'reason'
  end

end
