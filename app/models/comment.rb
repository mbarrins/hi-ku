class Comment < ApplicationRecord
  belongs_to :poem
  belongs_to :user
end
