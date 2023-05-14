# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :recently_viewed_books

  has_many :book_users
  has_many :books, through: :book_users

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  scope :with_orders, -> { joins(:orders).distinct }
  scope :with_recently_viewed_books, -> { joins(:recently_viewed_books).distinct }

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end
end
