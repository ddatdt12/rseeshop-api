# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Update user in the database with random email and name
users = User.where(email: '')

# create transaction to update user
# ActiveRecord::Base.transaction do
#   users.each do |user|
#     success = user.update(
#       email: Faker::Internet.email,
#       password: '123456',
#     )
#     puts "Updated user: #{user.id} #{success ? 'success' : 'failed'}"
#     if !success
#       puts user.errors.full_messages
#     end
#   end
# end
#
# puts 'Updated users'
require 'csv'
# books = Book.all.includes(:book_ratings)
# ActiveRecord::Base.transaction do
#   books.each do |book|
#     book.update_rating
#     puts "Updated book: #{book.id}"
#   end
# end
#
#
#
# # users = User.all
# # genres = Genre.all
# # genre_map = genres.each_with_object({}) do |genre, hash|
# #   hash[genre.id] = genre
# # end
#
# User.update("favourite_genres = ''")



book_csv_path = Rails.root.join('db', 'item_based_v2.csv')

isbn_item_based = {}
CSV.foreach(book_csv_path) do |row|
  isbn_item_based[row[0]] = row[1..-1]
end

books = Book.where(isbn: isbn_item_based.keys)

ActiveRecord::Base.transaction do
  books.each do |book|
    item_based_isbns_str = isbn_item_based[book.isbn].join(';')
    if book.update(item_related_book_str: item_based_isbns_str)
      puts "Updated book: #{book.id}"
    else
      puts "Failed to update book: #{book.id}"
    end
  end
end


# CSV.foreach(book_csv_path, headers: true) do |row|
#   isbn = row[0]
#   book = Book.find_by(isbn: isbn)
# end
