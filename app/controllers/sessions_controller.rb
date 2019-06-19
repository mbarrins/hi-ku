class SessionsController < ApplicationController
  def new
    @page_title = "Log in"

    if logged_in?
      redirect_to home_path
    end
  end

  def create
    user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if !!user
      session[:user_id] = user.id
      redirect_to home_path
    else
      (flash[:errors] ||= []) << "The username and/or password are not correct."
      redirect_to new_user_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end
end
