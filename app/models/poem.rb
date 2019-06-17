class Poem < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :user_id, counter_cache: true
  belongs_to :genre, counter_cache: true
  belongs_to :mood, counter_cache: true
  has_many :likes
  has_many :users_who_liked, through: :likes, source: :user
  has_many :comments  
  has_many :users_who_commented, through: :comments, source: :user

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
