class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_selection, except: [:new, :create, :index]
  before_action :current_user_only, except: [:show, :new, :create]
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
    if logged_in?
      redirect_to home_path
    else
      @page_title = "Register New User"
      @user = User.new
      @submit_button_text = "Sign Up"
      @cancel_button_text = "Cancel and Login"
      @cancel_path = login_path
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to welcome_path
    else
      flash.now[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
    @page_title = "Edit Your Profile"
  end

  def update
    if !!@user.try(:authenticate, params[:user][:password])
      params[:user].delete(:password)
    end

    @user.update(user_params)

    if @user.valid?
      flash[:notices] = ["Your details have been updated"]

      if request.referer[-9..-1] == "/settings"
        redirect_to settings_path
      else
        redirect_to @user
      end
    else
      session[:return_to] ||= request.referer
      flash[:errors] = @user.errors.full_messages
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    User.destroy(@user.id)
    session.delete :user_id
    flash[:notices] = ["Your Profile has been deleted"]
    redirect_to signup_path
  end

  def settings
    @page_title = "Change Account Settings"
    @submit_button_text = "Save Changes"
    @cancel_button_text = "Cancel Changes"
    @cancel_path = @user
    @allow_delete = true
    if !!params[:confirm_delete]
      @confirm_delete = true
    end
  end

  def my_poems
    @page_title = "My Poems"
    @poems = @user.poems.order(:title).page(page_params).per(12)
  end

  def liked_poems
    @page_title = "My Liked Poems"
    @poems = @user.liked_poems.order(:title).page(page_params).per(12)
  end

  def comments
    @page_title = "My Comments"
    @poems = @user.commented_poems.order(:title).page(page_params).per(12)
    
    if params[:edit_comment]
      @edit_comment = Comment.find(params[:edit_comment])
    end
  end

  def saved_poems
    @page_title = "My Saved Poems"
    @poems = @user.bookmarked_poems.order(:title).page(page_params).per(12)
  end

  def haiku_history
    @page_title = "History"
  end

  def welcome
    @page_title = "Welcome to Hi!Ku"
  end

  private

  def set_selection
    if params[:id]
      @user = User.find(params[:id]) rescue nil
      if !@user
        flash[:errors] = ["That author could not be found, please try another page."]
        redirect_to (request.referer || root_path)
      end
    else
      @user = User.find(current_user_id)
    end
  end

  def current_user_only
    if @user.id != current_user_id
      redirect_to @user
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
