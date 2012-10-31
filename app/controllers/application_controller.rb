class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :init
  after_filter :remember_request

  def current_user
    User.find session[:user_id]
  end

  private

  def init
    @color_date = Colorable.day_of_year
    @user = current_user
    unless params[:controller] == "links"
      @links = Link.all(:sort=>"created_at desc", :limit=>20)
    end
    @search = params["search"]
  end

  def remember_request
    session[:previous_page] = request.url
    puts request.url
  end

  def back_or_home
    begin
      redirect_to session[:previous_page]
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
end
