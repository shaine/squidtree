class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

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
    @comment_logs = SiteActivity.all(:conditions=> {:loggable_type => 'Comment'}, :limit=>3, :sort=>"created_at DESC")

    if params[:page] && params[:page].to_i > 1
      @outer_title = "Page #{params[:page]}"
    end
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

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: "layouts/application", status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
