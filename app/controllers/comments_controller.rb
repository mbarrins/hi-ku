class CommentsController < ApplicationController
  before_action :set_selection, only: [:edit, :update, :destroy]
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

  def like_params
    params.require(:like).permit(:user_id, :poem_id)
  end
end
