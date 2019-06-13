class CreatePoems < ActiveRecord::Migration[5.2]
  def change
    create_table :poems do |t|
      t.references :user, foreign_key: true
      t.references :genre, foreign_key: true
      t.references :mood, foreign_key: true
      t.string :title
      t.string :line_1
      t.string :line_2
      t.string :line_3

      t.timestamps
    end
  end
end
