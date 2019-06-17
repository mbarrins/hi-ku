class LikesController < ApplicationController
  before_action :require_login
  
  def create
    session[:return_to] ||= request.referer
    Like.create(like_params)
    redirect_to session.delete(:return_to)
  end

  def destroy
    Like.find(params[:id]).destroy
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :poem_id)
  end
end
