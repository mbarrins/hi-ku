class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user_id, :require_login

  def logged_in?
    !!session[:user_id]
  end

  def current_user_id
    session[:user_id]
  end

  def require_login
    if !logged_in?
      redirect_to login_path
    end
  end

end
