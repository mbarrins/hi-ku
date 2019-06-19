class Word < ApplicationRecord
  belongs_to :user

  validates :word, presence: true, uniqueness: true
  validates :syllable, presence: true
  validates :syllable, numericality: {only_integer: true, greater_than: 0, less_than: 20 }
end
