# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_favorite_books_on_book_id  (book_id)
#  index_favorite_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class FavoriteBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :with_book, -> { includes(:book) }
end
