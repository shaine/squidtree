class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :start_style_date
 
  private
 
  def start_style_date
    @color_date = Colorable.day_of_year
  end
end
