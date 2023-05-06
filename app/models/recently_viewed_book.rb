# frozen_string_literal: true

class RecentlyViewedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :with_book, -> { includes(:book) }
end
