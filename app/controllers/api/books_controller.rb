# frozen_string_literal: true

module Api
  class BooksController < Api::BaseController
    include Pagy::Backend
    before_action :attempt_get_user_id, only: [:show]
    before_action :set_book, only: [:show, :related_books]
    def index
      books = Book.all
      # Sorting
      if params[:sort].present?
        sort_by = params[:sort].split(',')
        books = books.order(sort_by)
      end

      # Pagination with Pagy
      @pagy, books = pagy(books, items: params[:per_page])

      meta = { pagination:
                 {  per_page: @pagy.items,
                    total_pages: @pagy.pages,
                    total_objects: @pagy.count,
                    page: @pagy.page,
                    next_page: @pagy.next,
                    prev_page: @pagy.prev } }

      render_success books, meta:, serializer: BookSerializer
    end

    def show
      # Update recently viewed books
      if @current_user_id.present?
        RecentlyViewedBooks::UpdateService.call(user_id: @current_user_id,
                                                book_id: @book.id)
      end

      render_success @book, serializer: BookSerializer
    end

    def related_books
      render_success @book.related_books, serializer: BookSerializer
    end

    def top_rated_books
      bookRatings = BookRating.group(:book_id).order('avg(rating) desc').limit(10).average(:rating)
      bookRatings = bookRatings.map do |book_id, rating|
        book = Book.find_by_id(book_id)
        book.rating = rating
        book
      end

      render_success bookRatings, serializer: BookSerializer
    end

    private

    def set_book
      @book = Book.find_by_id(params[:id])

      if @book.blank?
        render_error 'Book not found', :not_found
      end
    end
  end
end
