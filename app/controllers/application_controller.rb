class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :init_common_values
  before_filter :get_cart

  private

  def get_cart
    @cart = Cart.where(session_id: session.id).first_or_create
  end

  def init_common_values 
    @body_class = request.path.gsub(/\/?(en\/|es\/)?([^\/]+)(.*)/,'\\2')
    @og_image = view_context.image_url('RTG_Feature.jpg')
    @og_description = "Reason To Give provides a shopping/giving experience that's simple, quick, and personal. We connect people who give a damn with people who need a hand."
  end

end