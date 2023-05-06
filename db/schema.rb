# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_230_506_044_751) do
  create_table 'authors', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name'
  end

  create_table 'books', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'isbn', null: false
    t.integer 'price', default: 0, null: false
    t.integer 'year_of_publication', null: false
    t.string 'publisher', null: false
    t.string 'description'
    t.string 'image_s'
    t.string 'image_m'
    t.string 'image_l'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'author'
    t.bigint 'author_id', null: false
    t.index ['author_id'], name: 'index_books_on_author_id'
    t.index ['isbn'], name: 'index_books_on_isbn', unique: true
    t.index ['title'], name: 'index_books_on_title'
  end

  create_table 'cart_items', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'cart_id', null: false
    t.bigint 'book_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['book_id'], name: 'index_cart_items_on_book_id'
    t.index ['cart_id'], name: 'index_cart_items_on_cart_id'
  end

  create_table 'carts', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'favorite_books', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'book_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['book_id'], name: 'index_favorite_books_on_book_id'
    t.index ['user_id'], name: 'index_favorite_books_on_user_id'
  end

  create_table 'genre_books', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'genre_id', null: false
    t.bigint 'book_id', null: false
    t.index ['book_id'], name: 'index_genre_books_on_book_id'
    t.index ['genre_id'], name: 'index_genre_books_on_genre_id'
  end

  create_table 'genres', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name', null: false
    t.index ['name'], name: 'index_genres_on_name', unique: true
  end

  create_table 'isbn_genres', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'isbn', null: false
    t.string 'genre', null: false
    t.index %w[isbn genre], name: 'index_isbn_genres_on_isbn_and_genre', unique: true
  end

  create_table 'recently_viewed_books', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'book_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['book_id'], name: 'index_recently_viewed_books_on_book_id'
    t.index ['user_id'], name: 'index_recently_viewed_books_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'books', 'authors'
  add_foreign_key 'cart_items', 'books'
  add_foreign_key 'cart_items', 'carts'
  add_foreign_key 'carts', 'users'
  add_foreign_key 'favorite_books', 'books'
  add_foreign_key 'favorite_books', 'users'
  add_foreign_key 'genre_books', 'books'
  add_foreign_key 'genre_books', 'genres'
  add_foreign_key 'recently_viewed_books', 'books'
  add_foreign_key 'recently_viewed_books', 'users'
end
