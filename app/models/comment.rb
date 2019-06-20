class Comment < ApplicationRecord
  belongs_to :poem, counter_cache: true
  belongs_to :user, counter_cache: true

  def created_date
    self.created_at.strftime("%d/%m/%Y")
  end

  def updated_date
    self.updated_at.strftime("%d/%m/%Y")
  end
end
