# frozen_string_literal: true

# == Schema Information
#
# Table name: recently_viewed_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_recently_viewed_books_on_book_id  (book_id)
#  index_recently_viewed_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class RecentlyViewedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :with_book, -> { includes(:book) }
end
