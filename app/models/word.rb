class Word < ApplicationRecord
  belongs_to :user

  validates :word, presence: true
  validates :syllable, presence: true
end
