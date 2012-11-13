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
    @current_user = current_user
    unless params[:controller] == "links"
      @links = Link.all(:sort=>"created_at desc", :limit=>20)
    end
    @search = params["search"]
    @comment_logs = SiteActivity.all(:conditions=> {:loggable_type => 'Comment'}, :limit=>3, :sort=>"created_at DESC")

    if params[:page] && params[:page].to_i > 1
      @outer_title = "Page #{params[:page]}"
    end

    @months = Post.first(:sort=>"created_at ASC").created_at.to_date.all_months_until Post.first(:sort=>"created_at DESC").created_at.to_date
    @months.reverse!
    @months.reject!{|item|
      count = Post.count(
        :created_at => {
          '$lt' => (item >> 1).midnight,
          '$gt' => item.midnight
        }
      )
      count <= 0
    }
  end

  def remember_request
    session[:previous_page] = request.url
  end

  def back_or_home
    begin
      redirect_to session[:previous_page]
    rescue
      redirect_to root_url
    end
  end
end
