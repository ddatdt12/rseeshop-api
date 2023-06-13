# frozen_string_literal: true

# == Schema Information
#
# Table name: genres
#
#  id   :bigint           not null, primary key
#  name :string(255)      not null
#
# Indexes
#
#  index_genres_on_name  (name) UNIQUE
#
class Genre < ApplicationRecord
end
