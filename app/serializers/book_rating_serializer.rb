# frozen_string_literal: true

# == Schema Information
#
# Table name: book_reviews
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
#  index_book_reviews_on_book_id              (book_id)
#  index_book_reviews_on_book_id_and_user_id  (book_id,user_id) UNIQUE
#  index_book_reviews_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

class BookRatingSerializer < ActiveModel::Serializer
  attributes :id, :rating, :user_id, :book_id, :book, :created_at, :updated_at

  def book
    ActiveModelSerializers::SerializableResource.new(object.book, serializer: BookSerializer)
  end
end
