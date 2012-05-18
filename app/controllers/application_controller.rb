class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :init

  def current_user
    User.find session[:user_id]
  end

  private

  def init
    @color_date = Colorable.day_of_year

    @search = params["search"]
  end
end
