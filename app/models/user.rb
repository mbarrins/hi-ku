class User < ApplicationRecord
  has_many :poems, dependent: :destroy
  has_many :genres, -> {distinct}, through: :poems
  has_many :moods, -> {distinct}, through: :poems
  has_many :likes, dependent: :destroy
  has_many :liked_poems, through: :likes, source: :poem
  has_many :liked_genres, through: :liked_poems, source: :genre
  has_many :liked_moods, through: :liked_poems, source: :mood
  has_many :comments, dependent: :destroy
  has_many :commented_poems, through: :comments, source: :poem
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_poems, through: :bookmarks, source: :poem
  has_many :user_genres, dependent: :destroy
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

  def most_liked_genre
    self.liked_genres.map.with_object(Hash.new(0)) { |genre,h| h[genre] += 1 }.max_by(&:first).first
  end

  def most_liked_mood
    self.liked_moods.map.with_object(Hash.new(0)) { |mood,h| h[mood] += 1 }.max_by(&:first).first
  end

  def most_liked_categories_poems
    Poem.where(genre: self.most_liked_genre, mood: self.most_liked_mood)
  end

  def suggested_poems
    self.liked_poems.map do |poem| 
      poem.poems_also_liked.reject{|p| p.user_id == self.id || p.users_who_liked.include?(self)}
    end.flatten.map.with_object(Hash.new(0)) { |poem,h| h[poem] += 1 }.sort_by{|poem, count| count}.reverse.to_h.keys
  end
end
