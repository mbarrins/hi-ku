class Genre < ApplicationRecord
  has_many :poems
  has_many :users, through: :poems
  has_many :user_genres
  has_many :users, through: :user_genres

  def top_poems(no_of_poems)
    #self.poems.order(no_of_likes: :desc)
    self.poems.sort_by(&:custom_method)[0..4]
  end
end
