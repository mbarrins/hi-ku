class Genre < ApplicationRecord
  has_many :poems
  has_many :authors, through: :poems
  has_many :user_genres
  has_many :users, through: :user_genres
  has_many :likes, through: :poems

  def top_poems(no_of_poems)
    self.poems.order(likes_count: :desc).limit(no_of_poems)
  end
end
