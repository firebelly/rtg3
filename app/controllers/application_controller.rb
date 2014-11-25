class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :init_common_values
  before_filter :get_cart

  private

  def get_cart
    @cart = Cart.where(session_id: request.session_options[:id]).first_or_create
  end

  def init_common_values 
    body_class = request.path.gsub(/\/?(en\/|es\/)?([^\/]+)(.*)/,'\\2')
    body_class = body_class.gsub(/\-page/, '')
    @body_class = "{body_class}"
  end
end