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

books = Book.all.includes(:book_ratings)
ActiveRecord::Base.transaction do
  books.each do |book|
    book.update_rating
    puts "Updated book: #{book.id}"
  end
end
