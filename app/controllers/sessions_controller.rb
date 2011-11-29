class SessionsController < ApplicationController
  def new
    if user = User.find_by_password_digest(cookies[:digest])
      session[:user_id] = user.id
      redirect_to user, :notice => "Welcome back #{user.firstname}!"
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if params["remember_me"] == "1"
        cookies[:digest] = {:value => user.password_digest, :expires => Time.now + 360000}
      else
        cookies[:digest] = nil
      end
      redirect_to user, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    user = User.find_by_password_digest(cookies[:digest])
	session[:member_id] = nil
    cookies[:digest] = nil
    redirect_to root_url, :notice => "See you later #{user.firstname}!"
  end
end
