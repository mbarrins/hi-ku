class CommentsController < ApplicationController
  before_action :set_selection, only: [:edit, :update, :destroy]
  before_action :require_login
  
  def new
    session[:return_to] ||= request.referer
    @comment = Comment.new
  end

  def create
    Comment.create(comment_params)
    redirect_to session.delete(:return_to)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_selection
    @comment = Comment.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:user_id, :poem_id)
  end
end
