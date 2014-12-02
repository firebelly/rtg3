class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :init_common_values
  before_filter :get_cart

  private

  def get_cart
    @cart = Cart.where(session_id: session.id, order_id: nil).first_or_create
  end

  def init_common_values 
    @body_class = request.path.gsub(/\/?(en\/|es\/)?([^\/]+)(.*)/,'\\2')
    gon.client_token = generate_client_token
  end

  private
  def generate_client_token
    Braintree::ClientToken.generate
  end
end