class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :start_style_date, :find_outer_title
 
  private
 
  def start_style_date
    @color_date = Colorable.day_of_year
  end

  def find_outer_title
    if !params[:month].nil?
      @outer_title = params[:month]
    elsif !params[:tag].nil?
      @outer_title = params[:tag]
    end
  end
end
