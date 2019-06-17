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
  validates :password, length: { minimum: 6, maximum: 20 }, allow_nil: true

  has_secure_password
  strip_attributes collapse_spaces: true, replace_newlines: true
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
