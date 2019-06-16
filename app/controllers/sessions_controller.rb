class SessionsController < ApplicationController
  def name
  end

  def create
    user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if !!user
      session[:user_id] = user.id
      redirect_to user
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
