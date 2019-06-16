class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user_id

  def logged_in?
    !!session[:user_id]
  end

  def current_user_id
    session[:user_id]
  end

end
