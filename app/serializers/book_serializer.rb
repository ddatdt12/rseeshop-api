# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                    :bigint           not null, primary key
#  author                :string(255)      not null
#  description           :text(65535)      not null
#  image_l               :string(255)
#  image_m               :string(255)
#  image_s               :string(255)
#  isbn                  :string(20)       not null
#  item_related_book_str :string(255)
#  price                 :integer          not null
#  publisher             :string(255)      not null
#  rating_avg            :float(24)        default(0.0)
#  rating_count          :integer          default(0)
#  related_book_str      :text(65535)
#  tag_str               :text(65535)
#  title                 :string(255)      not null
#  year_of_publication   :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_books_on_isbn        (isbn) UNIQUE
#  index_books_on_rating_avg  (rating_avg)
#

class BookSerializer < ActiveModel::Serializer
  attributes :id, :isbn, :title, :description, :price, :author, :publisher, :year_of_publication, :image_s,
             :image_m, :image_l, :tags, :rating_avg, :rating_count, :genres, :user_rating
  def tags
    object.tag_str.split(';')
  end
end
