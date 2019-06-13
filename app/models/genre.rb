class Genre < ApplicationRecord
  has_many :poems
  has_many :users, through: :poems
end
