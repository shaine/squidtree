class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :init
  after_filter :remember_request

  def current_user
    User.find session[:user_id]
  end

  rescue_from CanCan::AccessDenied do |exception|
    render "errors/error_403", status: 403
    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

  private

  def init
    @color_date = Colorable.day_of_year
    @current_user = current_user
    unless params[:controller] == "links"
      @links = Link.all(sort:"created_at desc", limit:20)
    end
    @search = params["search"]
    @comment_logs = SiteActivity.all(conditions: {loggable_type: "Comment"}, limit: 3, sort: "created_at DESC")

    if params[:page] && params[:page].to_i > 1
      @outer_title = "Page #{params[:page]}"
    end

    @months = Post.first(sort:"created_at ASC").created_at.to_date.all_months_until Post.first(sort:"created_at DESC").created_at.to_date
    @months.reverse!
    @months.reject!{|item|
      count = Post.count(
        created_at: {
          '$lt' => (item >> 1).midnight,
          '$gt' => item.midnight
        }
      )
      count <= 0
    }

    # Ability to disable responsive if
    # requested by a mobile user
    @classes = 'responsive'

    if request.user_agent =~ /Mobile|webOS/
      session[:is_mobile] = true
    end

    # if is_mobile cookie is set, but user agent isn't mobile
    if session[:is_mobile] && request.user_agent !~ /Mobile|webOS/
      @classes = ''
    end
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
