class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:sessions][:email])
    if @user && @user.authenticate(params[:sessions][:password])
      log_in @user
      remember @user
      flash[:success] = "You are logged in now."
      redirect_to root_path
    else
      flash[:danger] = "Invalid email/password pair."
      redirect_to root_path
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "You are now logged out."
    redirect_to root_path
  end

end
