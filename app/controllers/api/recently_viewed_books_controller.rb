# frozen_string_literal: true

module Api
  class RecentlyViewedBooksController < Api::BaseController
    before_action :authenticate_request!, only: [:index]

    def index
      recently_viewed_books = RecentlyViewedBook.all.order('updated_at DESC').limit(10)
                                                .where(user_id: @current_user.id).with_book.map(&:book)

      render_success recently_viewed_books
    end
  end
end
