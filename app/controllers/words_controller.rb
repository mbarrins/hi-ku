class WordsController < ApplicationController
  before_action :require_login
  
  def create
    if params[:commit] != "Cancel"
      words_params.each do |word, syllables|
        Word.create(word: word, syllable: syllables, user_id: current_user_id)
      end
    end
    
    if !params[:poem][:id]
      @poem = Poem.new(poems_params)
    else
      @poem = Poem.find(params[:poem][:id])
      @poem.update(poems_params)
    end

    if !@poem.valid?
      flash[:errors] = @poem.errors.full_messages
    end

    @genres = Genre.all
    @moods = Mood.all

    if !params[:poem][:id]
      render new_poem_path
    else
      render "poems/edit"
    end
  end

  private

  def words_params
    params.require(:words).permit!
  end

  def poems_params
    params.require(:poem).permit(:title, :line_1, :line_2, :line_3, :genre_id, :mood_id, :user_id)
  end
end
