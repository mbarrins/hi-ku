class UsersController < ApplicationController
  before_action :set_selection, only: [:show, :edit, :update, :destroy, :my_poems, :liked_poems, :my_comments, :saved_poems]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :new_like, :new_bookmark, only: [:home, :my_poems, :liked_poems, :my_comments, :saved_poems]

  def home
    @poems = @user.set_selection.page(page_params).per(12)
  end

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    @genres = Genre.all
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash.now[:errors] = @user.errors.full_messages
      @genres = Genre.all
      render new_user_path
    end
  end

  def edit
  end

  def update
  end
  
  def destroy

  end

  def my_poems
    @poems = @user.poems.order(:title).page(page_params).per(12)
  end

  def liked_poems
    @poems = @user.liked_poems.order(:title).page(page_params).per(12)
  end

  def my_comments
    @poems = @user.commented_poems.order(:title).page(page_params).per(12)
  end

  def saved_poems
    @poems = @user.bookmarked_poems.order(:title).page(page_params).per(12)
  end

  private

  def set_selection
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find(current_user_id)
    end
  end

  def user_params
    params[:user][:password].try(&:strip!)
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def page_params
    params[:page] ||= 1
  end

  def new_like
    @like = Like.new
  end

  def new_bookmark
    @bookmark = Bookmark.new
  end
end