class Genre < ApplicationRecord
  has_many :poems
  has_many :authors, through: :poems
  has_many :likes, through: :poems

  default_scope { order(:name) }

  def top_poems(no_of_poems)
    self.poems.order(likes_count: :desc).limit(no_of_poems)
  end
end
