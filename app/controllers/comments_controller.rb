class CommentsController < ApplicationController
  before_action :set_selection, only: [:edit, :update, :destroy]
  before_action :require_login
  
  def new
    @comment = Comment.new
  end

  def create
    session[:return_to] ||= request.referer
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

  def comment_params
    params.require(:comment).permit(:user_id, :poem_id, :content)
  end
end
