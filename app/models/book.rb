# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                  :bigint           not null, primary key
#  author              :string(255)
#  description         :string(255)      not null
#  image_l             :string(255)
#  image_m             :string(255)
#  image_s             :string(255)
#  isbn                :string(255)      not null
#  price               :integer          not null
#  publisher           :string(255)      not null
#  related_book_str    :text(65535)
#  title               :string(1000)     not null
#  year_of_publication :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  author_id           :bigint           not null
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#  index_books_on_isbn       (isbn) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#
class Book < ApplicationRecord
  has_many :recently_viewed_books

  attr_accessor :rating
  attr_accessor :review_count


  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :year, presence: true
  validates :price, presence: true

  def as_json(options = {})
    super(options.merge({ except: %i[created_at updated_at] }))
  end

  def tags
    tag_str.split(';')
  end

  def related_books
    return [] if related_book_str.blank?
    isbns = related_book_str.split(';')
    Book.where(isbn: isbns)
  end
end
