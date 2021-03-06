module SessionsHelper

  def log_in user
    session[:user_id] = user.id
    @current_user = user
  end

  def remember user
    user.remember_token = User.new_token
    user.update_attribute(:remember_digest, User.digest(user.remember_token))
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def log_out
    forget current_user
    @current_user = nil
    session.delete(:user_id)
  end

  def forget user
    user.update_attribute(:remember_digest, nil)
    cookies.delete(:user_id)
    cookies.delete :remember_token
  end

  def logged_in?
    !current_user.nil?
  end

end
