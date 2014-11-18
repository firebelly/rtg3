class ReasonsController < ApplicationController

  before_filter :set_defaults

  def show
    @reason = Reason.friendly.find(params[:id])
  end

  private

  def set_defaults
    @body_class = 'reasons'
  end

end
