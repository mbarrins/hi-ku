class BookmarksController < ApplicationController
  before_action :require_login
  
  def create
    session[:return_to] ||= request.referer
    Bookmark.create(bookmark_params)
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    Bookmark.find(params[:id]).destroy
    redirect_to session.delete(:return_to)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :poem_id)
  end
end
