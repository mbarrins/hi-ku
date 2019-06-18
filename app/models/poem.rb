class Poem < ApplicationRecord

  belongs_to :author, class_name: :User, foreign_key: :user_id, counter_cache: true
  belongs_to :genre, counter_cache: true
  belongs_to :mood, counter_cache: true
  has_many :likes, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user
  has_many :users_also_likes, through: :users_who_liked, source: :likes
  has_many :poems_also_liked, through: :users_also_likes, source: :poem
  has_many :comments, dependent: :destroy
  has_many :users_who_commented, through: :comments, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :users_who_bookmarked, through: :bookmarks, source: :user

  validates :title, presence: true
  validates :line_1, presence: true
  validates :line_2, presence: true
  validates :line_3, presence: true
  validate :line_1_equals?, :line_2_equals?, :line_3_equals?


  strip_attributes collapse_spaces: true, replace_newlines: true


  def content
    "#{self.line_1}
    #{self.line_2}
    #{self.line_3}"
  end

    def pre_check
      check = self.content.downcase.gsub(/[^a-z0-9\s]/i, '')
      check.split(" ")
    end


    def check_db
      new_words = []
      words = self.pre_check
      words.each do |word|
      word_db = Word.find_by(word: word)
        if !word_db
          new_word = JSON.parse(RestClient.get("https://api.datamuse.com/words?sp=#{word}&md=s"))
          word_info = new_word.find{|k| k['word'] == word}
            if word_info
                Word.create(word: word, syllable: word_info["numSyllables"], user_id: 1)
            else
                new_words << word
          end
        end
      end
        new_words
    end

    def line_1_equals?
      if self.line_number(self.line_1) != 5
        errors.add(:line_1, "syllables must be equal to five")
      end
    end

    def line_2_equals?
      if self.line_number(self.line_2) != 7
        errors.add(:line_2, "syllables must be equal to seven")
      end
    end

    def line_3_equals?
      if self.line_number(self.line_3) != 5
        errors.add(:line_3, "syllables must be equal to five")
      end
    end

    def line_split(line)
      words = line.downcase.gsub(/[^a-z0-9\s]/i, '')
      words.split(" ")
    end

    def line_number(line)
      line_count = 0
      words = self.line_split(line)
      words.each do |word|
        word_db = Word.find_by(word: word)
        # byebug
            if word_db
              line_count+= word_db.syllable
            else
              line_count += 99
            end
          end
         line_count
        end



  def no_of_comments
    self.comments.length
  end

  def no_of_likes
    self.likes.length
  end


  def liked_by_session_user?(user_id)
    !!Like.find_by(user_id: user_id, poem_id: self.id)
  end

  def user_like(user_id)
    Like.find_by(user_id: user_id, poem_id: self.id)
  end

  def commented_by_session_user?(user_id)
    !!Comment.find_by(user_id: user_id, poem_id: self.id)
  end

  def user_comment(user_id)
    Comment.find_by(user_id: user_id, poem_id: self.id)
  end

  def saved_by_session_user?(user_id)
    !!Bookmark.find_by(user_id: user_id, poem_id: self.id)
  end

  def user_bookmark(user_id)
    Bookmark.find_by(user_id: user_id, poem_id: self.id)
  end

end
