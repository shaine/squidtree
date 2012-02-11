class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init
 
  private
 
  def init
    @color_date = Colorable.day_of_year

    @search = params["search"]
  end
end
