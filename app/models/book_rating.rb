# frozen_string_literal: true

# == Schema Information
#
# Table name: book_ratings
#
#  id         :bigint           not null, primary key
#  rating     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_book_ratings_on_book_id              (book_id)
#  index_book_ratings_on_book_id_and_user_id  (book_id,user_id) UNIQUE
#  index_book_ratings_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class BookRating < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, uniqueness: { scope: :user_id }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
