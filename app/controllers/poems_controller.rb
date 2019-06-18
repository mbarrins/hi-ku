class PoemsController < ApplicationController
  before_action :set_selection, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    @poems = Poem.all
  end

  def show
    @comments = @poem.comments.order(created_at: :desc)
    @like = Like.new
    @bookmark = Bookmark.new
    @comment = Comment.new
    @poems = Kaminari.paginate_array(@poem.author.poems).page(page_params).per(6)
  end

  def new
    @poem = Poem.new
    @genres = Genre.all
    @moods = Mood.all
  end

  def create
    @poem = Poem.new(poems_params)
    @word_errors = @poem.check_db
    @poem.valid?
    @genres = Genre.all
    @moods = Mood.all

    if @word_errors.empty? && @poem.valid?
      @poem.save
      redirect_to @poem
    elsif !@word_errors.empty?
      flash[:errors] = @poem.errors.full_messages
      flash[:errors] << "Missing syllables for word(s), please add below."
      render new_poem_path
    else
      @word_errors = nil
      flash[:errors] = @poem.errors.full_messages
      render new_poem_path
    end
  end

  def edit
  end

  def update
  end

  def destroy

  end

  private

  def poems_params
    params.require(:poem).permit(:title, :line_1, :line_2, :line_3, :genre_id, :mood_id, :user_id)
  end

  def set_selection
    @poem = Poem.find(params[:id])
  end

  def page_params
    params[:page] ||= 1
  end
end
