class AddBookmarksCountToPoems < ActiveRecord::Migration[5.2]
  def change
    add_column :poems, :bookmarks_count, :integer
  end
end
