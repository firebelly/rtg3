class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :init_common_values
  before_filter :get_cart

  private

  def get_cart
    @cart = Cart.where(session_id: request.session_options[:id]).first_or_create
  end

  def init_common_values 
    body_id = request.path.gsub(/\/?(en\/|es\/)?([^\/]+)(.*)/,'\\2')
    body_id = body_id.gsub(/\-page/, '')
    @body_id = "#{body_id}-page"
    @body_class = ''
  end
end