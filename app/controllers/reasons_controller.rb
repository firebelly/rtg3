class ReasonsController < ApplicationController

  before_filter :set_defaults

  def index
  	@page = Page.friendly.find('give')
  	@promoted_reason = Reason.published.unfulfilled.promoted.limit(1)
  	@reasons = Reason.published.unfulfilled - @promoted_reason
  end

  def show
    @reason = Reason.friendly.find(params[:id])
  end

  private

  def set_defaults
    @body_class = 'reason'
  end

end
