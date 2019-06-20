class AddInspiredByToPoems < ActiveRecord::Migration[5.2]
  def change
    add_reference :poems, :inspired_by, index: true
    add_column :poems, :inspired_poems_count, :integer
  end
end
