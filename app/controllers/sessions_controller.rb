class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @user = User.find_by_uid(auth_hash["uid"])
    if @user
      render :text => "Welcome back #{@user.name}! You have already signed up."
    else
      @user = User.new :first_name => auth_hash["user_info"]["first_name"], :last_name => auth_hash["user_info"]["last_name"], :email => auth_hash["user_info"]["email"], :uid => auth_hash["uid"]
      @user.save

      render :text => "Hi #{@user.name}! You've signed up."
    end
  end

  def failure
  end

end
