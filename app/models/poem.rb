class Poem < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :mood
  has_many :likes
  has_many :users, through: :likes
  has_many :comments
  has_many :users, through: :comments
end
