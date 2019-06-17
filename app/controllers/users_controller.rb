class UsersController < ApplicationController
  before_action :set_selection, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

  def home
    @like = Like.new
    if !!params[:page]
      @poems = Poem.page(params[:page]).per(12)
    else
      params[:page] = 1
      @poems = Poem.page(1).per(12)
    end
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

  private

  def set_selection
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
  end

end

