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
#  index_users_on_legacy_id  (legacy_id) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :recently_viewed_books
  has_many :book_ratings

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validate :validate_favorite_genre, on: :update

  scope :with_orders, -> { includes(:orders) }
  scope :with_recently_viewed_books, -> { includes(:recently_viewed_books) }
  scope :with_recently_reviewed_books, -> { includes(:book_reviews) }

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end

  def favorite_genre_ids=(genre_ids)
    self.favorite_genre = genre_ids.join(';')
  end

  def favorite_genre_ids
    return [] unless favorite_genre

    favorite_genre.split(';')
  end
  def favorite_genres
    return [] unless favorite_genre

    Genre.where(id: favorite_genre_ids)
  end

  private

  def validate_favorite_genre
    return unless favorite_genre

    genre_ids = favorite_genre.split(';')
    return if Genre.where(id: genre_ids).count == genre_ids.count

    errors.add(:favorite_genre, 'is invalid')
  end
end
