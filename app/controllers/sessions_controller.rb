class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @user = User.find_by_uid(auth_hash["uid"])
    if @user
      render :text => "Welcome back #{@user.name}! You have already signed up."
    else
      @user = User.new :first_name => auth_hash["info"]["first_name"], :last_name => auth_hash["info"]["last_name"], :email => auth_hash["info"]["email"], :uid => auth_hash["uid"]
      @user.alias = @user.name

      render :text => "Hi #{@user.name}! You've signed up."
    end

    puts auth_hash
    session[:user_id] = @user.id
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end
end
