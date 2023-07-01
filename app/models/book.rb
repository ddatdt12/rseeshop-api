# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                  :bigint           not null, primary key
#  author              :string(255)      not null
#  description         :text(65535)      not null
#  image_l             :string(255)
#  image_m             :string(255)
#  image_s             :string(255)
#  isbn                :string(20)       not null
#  price               :integer          not null
#  publisher           :string(255)      not null
#  rating_avg          :float(24)        default(0.0)
#  rating_count        :integer          default(0)
#  related_book_str    :text(65535)
#  tag_str             :text(65535)
#  title               :string(255)      not null
#  year_of_publication :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_books_on_isbn        (isbn) UNIQUE
#  index_books_on_rating_avg  (rating_avg)
#
class Book < ApplicationRecord
  has_many :recently_viewed_books
  has_many :genre_books
  has_many :genres, through: :genre_books
  has_many :book_ratings

  attr_accessor :user_rating

  def as_json(options = {})
    super(options.merge({ except: %i[created_at updated_at] }))
  end

  def tags
    tag_str&.split(';') || []
  end

  def related_books
    return [] if related_book_str.blank?
    isbns = related_book_str.split(';')
    Book.where(isbn: isbns)
  end

  def update_rating
    self.rating_avg = book_ratings.average(:rating).to_f.round(1)
    self.rating_count = book_ratings.count
    save
  end
end
