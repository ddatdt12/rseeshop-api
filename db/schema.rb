# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_07_09_044304) do

  create_table "book_ratings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.integer "rating", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id", "user_id"], name: "index_book_ratings_on_book_id_and_user_id", unique: true
    t.index ["book_id"], name: "index_book_ratings_on_book_id"
    t.index ["user_id"], name: "index_book_ratings_on_user_id"
  end

  create_table "books", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "isbn", limit: 20, null: false
    t.integer "price", null: false
    t.integer "year_of_publication", null: false
    t.string "publisher", null: false
    t.string "image_s"
    t.string "image_m"
    t.string "image_l"
    t.string "author", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "related_book_str"
    t.text "tag_str"
    t.integer "rating_count", default: 0
    t.float "rating_avg", default: 0.0
    t.string "item_related_book_str"
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
    t.index ["rating_avg"], name: "index_books_on_rating_avg"
  end

  create_table "favorite_books", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_favorite_books_on_book_id"
    t.index ["user_id"], name: "index_favorite_books_on_user_id"
  end

  create_table "genre_books", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "book_id", null: false
    t.index ["book_id"], name: "index_genre_books_on_book_id"
    t.index ["genre_id"], name: "index_genre_books_on_genre_id"
  end

  create_table "genres", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "recently_viewed_books", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_recently_viewed_books_on_book_id"
    t.index ["user_id"], name: "index_recently_viewed_books_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "favorite_genre"
    t.integer "legacy_id"
    t.index ["legacy_id"], name: "index_users_on_legacy_id", unique: true
  end

  add_foreign_key "book_ratings", "books"
  add_foreign_key "book_ratings", "users"
  add_foreign_key "favorite_books", "books"
  add_foreign_key "favorite_books", "users"
  add_foreign_key "genre_books", "books"
  add_foreign_key "genre_books", "genres"
  add_foreign_key "recently_viewed_books", "books"
  add_foreign_key "recently_viewed_books", "users"
end
