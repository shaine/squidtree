class ErrorsController < ApplicationController
  def error_404
    render :error_404, status: 404
  end

  def error_403
    render :error_403, status: 403
  end

  def error_500
    render :error_500, status: 500
  end
end
