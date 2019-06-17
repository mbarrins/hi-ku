class Poem < ApplicationRecord

  belongs_to :author, class_name: :User, foreign_key: :user_id, counter_cache: true
  belongs_to :genre, counter_cache: true
  belongs_to :mood, counter_cache: true
  has_many :likes
  has_many :users_who_liked, through: :likes, source: :user
  has_many :comments
  has_many :users_who_commented, through: :comments, source: :user

  validates :title, presence: true
  validates :line_1, presence: true
  validate :line_1_equals?
  validates :line_2, presence: true
  validate :line_2_equals?
  validates :line_3, presence: true
  validate :line_3_equals?


  def line_1_equals?
    if self.line_1_number != 5
      errors.add(:line_1, "syllables must be equal to five")
    end
  end

  def line_2_equals?
    if self.line_2_number != 7
      errors.add(:line_2, "syllables must be equal to seven")
    end
  end

  def line_3_equals?
    if self.line_3_number != 5
      errors.add(:line_3, "syllables must be equal to five")
    end
  end

  def line_1_split
    words = self.line_1.split(" ")
    words.each{|word| word.downcase}
  end

  def line_1_number
    line = []
    words = self.line_1_split
    words.each do |word|
      new_word = JSON.parse(RestClient.get("https://api.datamuse.com/words?sp=#{word}&md=s"))
      word_info = new_word.find{|k| k['word'] == word}
      line << word_info["numSyllables"]
    end
    line.sum
  end


  def line_2_split
    words = self.line_2.split(" ")
    words.each{|word| word.downcase}
  end

  def line_2_number
    line = []
    words = self.line_2_split
    words.each do |word|
    new_word = JSON.parse(RestClient.get("https://api.datamuse.com/words?sp=#{word}&md=s"))
    word_info = new_word.find{|k| k['word'] == word}
    line << word_info["numSyllables"]
    end
    line.sum
  end

  def line_3_split
    words = self.line_3.split(" ")
    words.each{|word| word.downcase}
  end

  def line_3_number
    line = []
    words = self.line_3_split
    words.each do |word|
    new_word = JSON.parse(RestClient.get("https://api.datamuse.com/words?sp=#{word}&md=s"))
    word_info = new_word.find{|k| k['word'] == word}
    line << word_info["numSyllables"]
    end
    line.sum
  end


  def no_of_comments
    self.comments.length
  end

  def no_of_likes
    self.likes.length
  end

  def content
    "#{self.line_1}
    #{self.line_2}
    #{self.line_3}"
  end

  def liked_by_session_user?(user_id)
    !!Like.find_by(user_id: user_id, poem_id: self.id)
  end

  def user_like(user_id)
    Like.find_by(user_id: user_id, poem_id: self.id)
  end
end
