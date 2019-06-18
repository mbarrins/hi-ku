class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :word
      t.integer :syllable 
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
