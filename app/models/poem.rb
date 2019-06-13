class Poem < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :mood
end
