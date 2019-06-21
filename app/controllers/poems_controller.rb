class PoemsController < ApplicationController
  before_action :require_login
  before_action :set_selection, only: [:show, :edit, :update, :destroy]
  before_action :set_types, only: [:index, :show, :new, :create, :edit, :update]
  before_action :new_items, only: [:index, :show]
  before_action :searched, only: [:index]


  def index
    if @searched
      @page_title = "Searched Haiku"
    else
      @page_title = "All Haiku"
    end

    if params[:commit] == "Clear Search"
      params.delete(:title)
      params.delete(:body)
      params.delete(:genre_id)
      params.delete(:mood_id)
    end

    @poems = Poem.genre_is(search_params[:genre_id]).mood_is(search_params[:mood_id]).title_contains(search_params[:title]).body_contains(search_params[:body]).order(created_at: :desc).page(page_params).per(12)

    if @poems.empty?
      flash.now[:errors] = ["Your search returned no results."]
      render poems_search_path
    end
  end

  def show
    @page_title = @poem.title
    @comments = @poem.comments.order(created_at: :desc)
    @poems = Kaminari.paginate_array(@poem.author.poems).page(page_params).per(6)

    if params[:edit_comment]
      @edit_comment = Comment.find(params[:edit_comment])
    end
  end

  def new
    if !!params[:id]
      @page_title = "New Inspired Haiku"
      initial_poem = Poem.find(params[:id])
      @poem = initial_poem.dup
      @poem.inspired
      @poem.inspired_by = initial_poem
    else
      @page_title = "New Haiku"
      @poem = Poem.new
    end

      @genres = Genre.all
      @moods = Mood.all
  end

  def random_haiku
    @page_title = "Haiku Randomizer"
    @poem1 = Poem.all.sample
    @poem2 = Poem.all.sample
    @poem3 = Poem.all.sample
  end

  def create
    if !!params[:poem][:inspired_by]
      @page_title = "New Inspired Haiku"
    else
      @page_title = "New Haiku"
    end

    @poem = Poem.new(poems_params)
    @word_errors = @poem.check_db
    @poem.valid?
    @genres = Genre.all
    @moods = Mood.all

    if @word_errors.empty? && @poem.valid?
      @poem.save
      redirect_to @poem
    elsif !@word_errors.empty?
      flash.now[:errors] = @poem.errors.full_messages
      flash.now[:errors] << "Missing syllables for word(s), please add below."
      render new_poem_path
    else
      @word_errors = nil
      flash.now[:errors] = @poem.errors.full_messages
      render new_poem_path
    end
  end

  def edit
    @poem ||= set_selection
    @page_title = "Edit Poem"
    if !!params[:confirm_delete]
      @confirm_delete = true
    end
  end

  def update
    @poem.update(poems_params)
    @word_errors = @poem.check_db
    @poem.valid?
    @genres = Genre.all
    @moods = Mood.all

    if @word_errors.empty? && @poem.valid?
      @poem.save
      flash[:notices] = ["Your Haiku has been updated"]
      redirect_to @poem
    elsif !@word_errors.empty?
      flash.now[:errors] = @poem.errors.full_messages
      flash.now[:errors] << "Missing syllables for word(s), please add below."
      render new_poem_path
    else
      @word_errors = nil
      flash.now[:errors] = @poem.errors.full_messages
      render new_poem_path
    end
  end

  def destroy
    @poem.destroy
    flash[:notices] = ["Haiku has been deleted"]
    redirect_to my_haiku_path
  end

  def search
    @page_title = "Search all Haiku"
    @poem = Poem.new
    @genres = Genre.all
    @moods = Mood.all
    params[:search] = Hash.new
  end


  private

  def poems_params
    params.require(:poem).permit(:title, :line_1, :line_2, :line_3, :genre_id, :mood_id, :user_id, :inspired_by_id)
  end

  def set_selection
    @poem = Poem.find(params[:id]) rescue nil
    if !@poem
      flash[:errors] = ["That poem could not be found, please try another page."]
      redirect_to (request.referer || root_path)
    end
    @poem
  end

  def page_params
    params[:page] ||= 1
  end

  def set_types
    @genres = Genre.all
    @moods = Mood.all
  end

  def new_items
    @like = Like.new
    @bookmark = Bookmark.new
    @comment = Comment.new
  end

  def search_params
    params.permit(:title, :body, :genre_id, :mood_id)
  end

  def searched
    @searched = params[:title].present? || params[:body].present? || params[:genre_id].present? || params[:mood_id].present?
  end
end
