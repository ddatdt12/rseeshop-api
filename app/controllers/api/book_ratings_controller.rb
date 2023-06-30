# frozen_string_literal: true

module Api
  class BookRatingsController < Api::BaseController
    include Pagy::Backend
    before_action :authenticate_request!
    before_action :set_book_rating, only: [:create_or_update]

    def index
      bookRatings = BookRating.includes(:book).where(user_id: @current_user.id)
      # Sorting
      if params[:sort].present?
        sort_by = params[:sort].split(',')
        bookRatings = bookRatings.order(sort_by)
      else
        bookRatings = bookRatings.order(created_at: :desc)
      end

      # Pagination with Pagy
      @pagy, bookRatings = pagy(bookRatings, items: params[:per_page])

      meta = { pagination:
                 {  per_page: @pagy.items,
                    total_pages: @pagy.pages,
                    total_objects: @pagy.count,
                    page: @pagy.page,
                    next_page: @pagy.next,
                    prev_page: @pagy.prev } }

      render_success bookRatings, meta:, serializer: BookRatingSerializer
    end

    def format
      bookRatings = BookRating.includes(:book).where(user_id: @current_user.id)

      if params[:sort].present?
        sort_by = params[:sort].split(',')
        bookRatings = bookRatings.order(sort_by)
      else
        bookRatings = bookRatings.order(created_at: :desc)
      end

      isbn_ratings = bookRatings.each_with_object({}) do |bookRating, hash|
        hash[bookRating.book.isbn] = bookRating.rating
      end

      render_success isbn_ratings
    end

    def create_or_update
      if @bookRating.update(rating: params[:rating])
        render_success @bookRating, serializer: BookRatingSerializer
      else
        render_error @bookRating.errors.full_messages.join(', ')
      end
    end

    private

    def set_book_rating
      @bookRating = BookRating.find_or_create_by(book_id: params[:book_id], user_id: @current_user.id) do |book_review|
        book_review.rating = params[:rating]
      end
    end
  end
end
