class UsersController < ApplicationController
  before_action :set_selection, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

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
      redirect_to @user
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

  private

  def set_selection
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_login
    if !logged_in?
      redirect_to login_path
    end
  end
end

