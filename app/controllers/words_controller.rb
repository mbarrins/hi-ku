class WordsController < ApplicationController
  before_action :require_login
  
  def create
    words_params.each do |word, syllables|
      Word.create(word: word, syllable: syllables, user_id: current_user_id)
    end
    @poem = Poem.new(poems_params)
    @genres = Genre.all
    @moods = Mood.all
    render new_poem_path
  end

  private

  def words_params
    params.require(:words).permit!
  end

  def poems_params
    params.require(:poem).permit(:title, :line_1, :line_2, :line_3, :genre_id, :mood_id, :user_id)
  end
end
