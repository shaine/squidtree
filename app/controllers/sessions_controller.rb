class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by_uid(auth_hash["uid"])
    if !user
      user = User.new :first_name => auth_hash["info"]["first_name"], :last_name => auth_hash["info"]["last_name"], :email => auth_hash["info"]["email"], :uid => auth_hash["uid"]
      user.alias = user.name
    end

    session[:user_id] = user.id

    back_or_home
  end

  def failure
    flash[:notice] = "Login canceled."
    back_or_home
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been logged out."

    back_or_home
  end
end
