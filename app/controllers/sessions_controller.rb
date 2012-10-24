class SessionsController < ApplicationController
  def new
  end

  def create
    # Extract user details from hash
    auth_hash = request.env['omniauth.auth']
    user_details = {
      :first_name => auth_hash["info"]["first_name"],
      :last_name => auth_hash["info"]["last_name"],
      :alias => auth_hash["info"]["nickname"],
      :email => auth_hash["info"]["email"],
      :uid => auth_hash["uid"]
    }

    # Try to find existing or old user
    user = User.find_by_uid(auth_hash["uid"])
    user ||= User.find_by_first_name_and_last_name_and_uid(
      user_details[:first_name],
      user_details[:last_name],
      nil
    )

    # Set user details
    if !user
      user = User.new user_details
    elsif !user.valid?
      user.update_attributes user_details
    end

    # Save user
    unless user.save
      flash[:notice] = "User account failed to save."
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
