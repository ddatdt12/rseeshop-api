# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  favorite_genre  :string(255)
#  name            :string(255)
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :integer
#
# Indexes
#
#  index_email_user          (email) UNIQUE
#  index_users_on_legacy_id  (legacy_id) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :recently_viewed_books
  has_many :book_ratings
  has_many :books, through: :book_users

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validate :validate_favorite_genre, on: :update

  scope :with_orders, -> { includes(:orders) }
  scope :with_recently_viewed_books, -> { includes(:recently_viewed_books) }
  scope :with_recently_reviewed_books, -> { includes(:book_reviews) }

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end

  def favorite_genres=(genres)
    self.favorite_genre = genres.join(';')
  end

  private

  def validate_favorite_genre
    return unless favorite_genre

    genres = favorite_genre.split(';')
    return if Genre.where(name: genres).count == genres.count

    errors.add(:favorite_genre, 'is invalid')
  end
end
