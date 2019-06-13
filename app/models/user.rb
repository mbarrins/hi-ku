class User < ApplicationRecord
  has_many :poems
  has_many :genres, through: :poems
  has_many :moods, through: :poems
  has_many :likes
  has_many :poems, through: :likes
  has_many :comments
  has_many :poems, through: :comments
  has_many :user_genres
  has_many :genres, through :user_genres
end
