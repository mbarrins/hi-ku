class Comment < ApplicationRecord
  belongs_to :poem, counter_cache: true
  belongs_to :user, counter_cache: true
end
