# frozen_string_literal: true

module RecentlyViewedBooks
  class UpdateService < ApplicationService
    # @param [integer] user_id
    # @param [integer] book_id
    def initialize(user_id:, book_id:)
      super()

      @user_id = user_id
      @book_id = book_id
    end

    private

    attr_reader :user_id, :book_id

    # @return [RecentlyViewedBook]
    def perform
      recently_viewed_book = RecentlyViewedBook.find_by(user_id:, book_id:)
      if recently_viewed_book.present?
        recently_viewed_book.touch
      else
        # only keep 10 recently viewed books
        if RecentlyViewedBook.where(user_id:).count >= 10
          RecentlyViewedBook.where(user_id:).order('updated_at').first.destroy
        end
        RecentlyViewedBook.create(user_id:, book_id:)
      end
    end
  end
end
