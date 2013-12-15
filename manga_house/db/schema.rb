# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131215033135) do

  create_table "artist", primary_key: "artist_id", force: true do |t|
    t.integer "people_id", null: false
  end

  add_index "artist", ["people_id"], name: "fk_Artist_People1_idx", using: :btree
  add_index "artist", ["people_id"], name: "fk_artist_1", using: :btree

  create_table "author", primary_key: "author_id", force: true do |t|
    t.integer "people_id", null: false
  end

  add_index "author", ["people_id"], name: "fk_Author_People1_idx", using: :btree
  add_index "author", ["people_id"], name: "fk_author_1", using: :btree

  create_table "chapter", primary_key: "chapter_id", force: true do |t|
    t.integer "manga_id",      null: false
    t.integer "number"
    t.integer "volumn"
    t.date    "released_date"
  end

  add_index "chapter", ["manga_id"], name: "fk_Chapter_Manga1_idx", using: :btree
  add_index "chapter", ["manga_id"], name: "fk_chapter_1", using: :btree

  create_table "favourite_artist", id: false, force: true do |t|
    t.integer "user_id",   null: false
    t.integer "artist_id", null: false
  end

  add_index "favourite_artist", ["artist_id"], name: "fk_Favourite_Artist_Artist1_idx", using: :btree
  add_index "favourite_artist", ["artist_id"], name: "fk_favourite_artist_1", using: :btree
  add_index "favourite_artist", ["user_id"], name: "fk_favourite_artist_2", using: :btree

  create_table "favourite_author", id: false, force: true do |t|
    t.integer "user_id",   null: false
    t.integer "author_id", null: false
  end

  add_index "favourite_author", ["author_id"], name: "fk_Favourite_Author_Author1_idx", using: :btree
  add_index "favourite_author", ["author_id"], name: "fk_favourite_author_1", using: :btree
  add_index "favourite_author", ["user_id"], name: "fk_favourite_author_2", using: :btree

  create_table "favourite_genre", id: false, force: true do |t|
    t.integer "user_id",  null: false
    t.integer "genre_id", null: false
  end

  add_index "favourite_genre", ["genre_id"], name: "fk_Favourite_Genre_Genre1_idx", using: :btree
  add_index "favourite_genre", ["genre_id"], name: "fk_favourite_genre_1", using: :btree
  add_index "favourite_genre", ["user_id"], name: "fk_favourite_genre_2", using: :btree

  create_table "genre", primary_key: "genre_id", force: true do |t|
    t.string "name",        limit: 45
    t.string "description", limit: 45
  end

  create_table "manga", primary_key: "manga_id", force: true do |t|
    t.string  "name",            limit: 45
    t.string  "description",     limit: 45
    t.string  "image_directory", limit: 100
    t.integer "author_id",                               null: false
    t.integer "artist_id",                               null: false
    t.integer "publisher_id",                            null: false
    t.integer "completeness",                default: 0
  end

  add_index "manga", ["artist_id"], name: "fk_Manga_Artist1_idx", using: :btree
  add_index "manga", ["artist_id"], name: "fk_manga_1", using: :btree
  add_index "manga", ["author_id"], name: "fk_Manga_Author1_idx", using: :btree
  add_index "manga", ["author_id"], name: "fk_manga_2", using: :btree
  add_index "manga", ["publisher_id"], name: "fk_Manga_Publisher1_idx", using: :btree
  add_index "manga", ["publisher_id"], name: "fk_manga_4", using: :btree

  create_table "manga_has_genre", id: false, force: true do |t|
    t.integer "manga_id", null: false
    t.integer "genre_id", null: false
  end

  add_index "manga_has_genre", ["genre_id"], name: "fk_maga_has_genre_2", using: :btree
  add_index "manga_has_genre", ["manga_id"], name: "fk_maga_has_genre_1", using: :btree

  create_table "manga_has_genres", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", primary_key: "people_id", force: true do |t|
    t.string "first_name",      limit: 45
    t.string "last_name",       limit: 45
    t.date   "birthday"
    t.string "image_directory", limit: 100
  end

  create_table "publisher", primary_key: "publisher_id", force: true do |t|
    t.string "name",        limit: 45
    t.string "description", limit: 45
  end

  create_table "user", primary_key: "user_id", force: true do |t|
    t.string  "username",  limit: 45
    t.string  "email",     limit: 45
    t.string  "password",  limit: 45
    t.integer "people_id",            null: false
  end

  add_index "user", ["people_id"], name: "fk_User_People1_idx", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
