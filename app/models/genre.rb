class Genre < ApplicationRecord
  has_many :poems
  has_many :authors, through: :poems
  has_many :user_genres
  has_many :users, through: :user_genres

  def top_poems(no_of_poems)
    self.poems.mood.poems.joins(:likes).group(:id).order(Arel.sql('COUNT(likes.id) DESC')).limit(no_of_poems)
  end
end
