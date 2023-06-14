# frozen_string_literal: true

# == Schema Information
#
# Table name: genre_books
#
#  id       :bigint           not null, primary key
#  book_id  :bigint           not null
#  genre_id :bigint           not null
#
# Indexes
#
#  index_genre_books_on_book_id   (book_id)
#  index_genre_books_on_genre_id  (genre_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (genre_id => genres.id)
#
class GenreBook < ApplicationRecord
  belongs_to :book
  belongs_to :genre
end
