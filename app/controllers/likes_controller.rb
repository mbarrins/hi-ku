class LikesController < ApplicationController
  def create
    session[:return_to] ||= request.referer
    Like.create(like_params)
    redirect_to session.delete(:return_to)
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :poem_id)
  end
end
