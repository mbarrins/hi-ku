class AddBookmarksCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bookmarks_count, :integer
  end
end
