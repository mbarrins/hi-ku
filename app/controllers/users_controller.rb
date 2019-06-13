class UsersController < ApplicationController
  before_action :set_selection, only [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
  end

  def edit
  end

  def update
  end
  
  def destroy

  end

  private

  def users_params

  end

  def set_selection
    @user = User.find(params[:id])
  end
end
