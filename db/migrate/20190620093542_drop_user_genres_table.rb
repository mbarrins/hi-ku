class DropUserGenresTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_genres do |t|
      t.references :user, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
