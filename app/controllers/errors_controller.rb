class ErrorsController < ApplicationController
  def error_404
    @error_code = '404'
    @error_message = "The page you're looking for could not be found."
    respond_to do |format|
      format.html { render "errors/error", status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def error_422
    @error_code = '422'
    @error_message = "The server was confused as to how to process your request."
    respond_to do |format|
      format.html { render  "errors/error", status: 422 }
      format.all { render nothing: true, status: 422 }
    end
  end

  def error_500
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
  end
end
