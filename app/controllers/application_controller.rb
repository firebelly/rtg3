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
    @og_description = "Reason to Give empowers people to transform their lives and set their own paths to success."
  end

end