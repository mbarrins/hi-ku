class User < ApplicationRecord
  has_many :poems
  has_many :genres, through: :poems
  has_many :moods, through: :poems
  has_many :likes
  has_many :liked_poems, through: :likes, source: :poem
  has_many :comments
  has_many :commented_poems, through: :comments, source: :poem
  has_many :user_genres
  has_many :selected_genres, through: :user_genres, source: :genre

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: {minimum: 6, maximum: 20}

  def full_name
    "#{first_name} #{last_name}"
  end
end
