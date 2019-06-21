class CommentsController < ApplicationController
  before_action :set_selection, only: [:update, :destroy]
  before_action :require_login
  
  def new
    @comment = Comment.new
  end

  def create
    session[:return_to] ||= request.referer
    Comment.create(comment_params)
    redirect_to session.delete(:return_to)
  end

  def update
    @comment.update(comment_params)
    if @comment.valid?
      session[:return_to] ||= request.referer.split("?").first
    else
      session[:return_to] ||= request.referer
    end
    redirect_to session.delete(:return_to)
    
  end

  def destroy
    session[:return_to] ||= request.referer.split("?").first
    Comment.find(params[:id]).destroy
    redirect_to session.delete(:return_to)
  end

  private

  def set_selection
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :poem_id, :content)
  end
end
