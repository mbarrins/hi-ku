class UsersController < ApplicationController
  before_action :set_selection, only: [:home, :show, :edit, :update, :destroy, :my_poems, :liked_poems, :my_comments, :saved_poems]
  before_action :require_login, only: [:home, :index, :show, :edit, :update, :destroy]
  before_action :new_like, :new_bookmark, only: [:home, :my_poems, :liked_poems, :my_comments, :saved_poems]

  def home
    @poems = Kaminari.paginate_array(@user.suggested_poems).page(page_params).per(12)
  end

  def index
    @users = User.all
  end

  def show
    @page_title = "Author Profile"
  end

  def new
    @page_title = "Register New User"
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
      render signup_path
    end
  end

  def edit
    @page_title = "Edit Your Profile"
  end

  def update
    @user = User.find(current_user_id)
    @user.update(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to login_path
    end
  end

  def destroy

  end

  def my_poems
    @page_title = "My Poems"
    @poems = @user.poems.order(:title).page(page_params).per(12)
  end

  def liked_poems
    @page_title = "My Liked Poems"
    @poems = @user.liked_poems.order(:title).page(page_params).per(12)
  end

  def my_comments
    @page_title = "My Comments"
    @poems = @user.commented_poems.order(:title).page(page_params).per(12)
  end

  def saved_poems
    @page_title = "My Saved Poems"
    @poems = @user.bookmarked_poems.order(:title).page(page_params).per(12)
  end

  def haiku_history
    @page_title = "History"
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
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :bio, :motto)
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
