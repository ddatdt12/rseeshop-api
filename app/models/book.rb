# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :cart_items
  has_many :recently_viewed_books
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :year, presence: true
  validates :price, presence: true
  validates :cover, presence: true

  def as_json(options = {})
    super(options.merge({ except: %i[created_at updated_at] }))
  end
end
