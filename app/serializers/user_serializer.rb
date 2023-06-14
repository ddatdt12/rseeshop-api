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
#  index_users_on_email      (email) UNIQUE
#  index_users_on_legacy_id  (legacy_id) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :created_at, :updated_at, :favorite_genres

  def favorite_genres
    object.favorite_genre&.split(';') || []
  end
end
