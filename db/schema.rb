# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_19_145702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "poem_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poem_id"], name: "index_bookmarks_on_poem_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "poem_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poem_id"], name: "index_comments_on_poem_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.integer "poems_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "poem_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poem_id"], name: "index_likes_on_poem_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "moods", force: :cascade do |t|
    t.string "name"
    t.integer "poems_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poems", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "genre_id"
    t.bigint "mood_id"
    t.string "title"
    t.string "line_1"
    t.string "line_2"
    t.string "line_3"
    t.integer "likes_count"
    t.integer "comments_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bookmarks_count"
    t.index ["genre_id"], name: "index_poems_on_genre_id"
    t.index ["mood_id"], name: "index_poems_on_mood_id"
    t.index ["user_id"], name: "index_poems_on_user_id"
  end

  create_table "user_genres", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_user_genres_on_genre_id"
    t.index ["user_id"], name: "index_user_genres_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "likes_count"
    t.integer "comments_count"
    t.integer "poems_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bookmarks_count"
    t.string "motto"
    t.text "bio"
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.integer "syllable"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_words_on_user_id"
  end

  add_foreign_key "bookmarks", "poems"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "poems"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "poems"
  add_foreign_key "likes", "users"
  add_foreign_key "poems", "genres"
  add_foreign_key "poems", "moods"
  add_foreign_key "poems", "users"
  add_foreign_key "user_genres", "genres"
  add_foreign_key "user_genres", "users"
  add_foreign_key "words", "users"
end
