class Poem < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :mood
  has_many :likes
  has_many :users, through: :likes
  has_many :comments
  has_many :users, through: :comments

  def no_of_likes
    self.likes.length
  end

  def content
    "#{self.line_1}
    #{self.line_2}
    #{self.line_3}"
  end
end
