class PoemsController < ApplicationController
  before_action :set_selection, only: [:show, :edit, :update, :destroy]
  def index
    @poems = Poem.all
  end

  def show
  end

  def new
    @poem = Poem.new
    @genres = Genre.all
    @moods = Mood.all
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

  def poems_params

  end

  def set_selection
    @poem = Poem.find(params[:id])
  end
end
