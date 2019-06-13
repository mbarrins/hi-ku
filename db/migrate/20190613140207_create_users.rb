class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.integer :likes_count
      t.integer :comments_count
      t.integer :poems_count

      t.timestamps
    end
  end
end
