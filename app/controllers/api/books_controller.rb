# frozen_string_literal: true

module Api
  class BooksController < Api::BaseController
    include Pagy::Backend
    before_action :attempt_get_user_id, only: [:show, :related_books]
    before_action :set_book, only: [:show, :item_based]
    before_action :authenticate_request!, only: [:get_books_by_favorate_genres]
    def index
      books = Book.all
      # Sorting
      if params[:sort].present?
        sort_by = params[:sort].split(',')
        books = books.order(sort_by)
      end

      if params[:isbns].present?
        books = books.where(isbn: params[:isbns].split(','))
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
        user_rating = BookRating.find_by(user_id: @current_user_id, book_id: @book.id)&.rating
        @book.user_rating = user_rating
      end

      render_success @book, serializer: BookSerializer
    end

    def related_books
      render_success @book.related_books, serializer: BookSerializer
    end

    def top_rated_books
      books = Book.order(rating_avg: :desc).limit(10)

      render_success books, serializer: BookSerializer
    end

    def get_books_by_favorate_genres
      user_genre_ids = @current_user.favorite_genres.pluck(:id)

      user_genre_ids.each_with_object([]) do |genre_id, books|
        books << Book.includes(:genres).where(genres: { id: genre_id }).order(rating_avg: :desc).limit(10)
      end

      render_success books.sample(10), serializer: BookSerializer
    end

    def recommendated_books
      return render_error 'Please provide ids', :bad_request if params[:ids].blank?

      ids = params[:ids].split(',')

      book_ids = ids || BookRating.where(book_id: ids).order(rating: :desc).limit(10).pluck(:book_id).uniq.each_with_object([]) do |book_id, book_ids|
        book_ids << book_id
      end

      # Cân phân biệt rating thích ghét

      books = Book.where(id: book_ids).order(rating_avg: :desc).limit(10)
      recommended_book_isbns = Set.new(books.pluck(:related_book_str).map { |str| str.split(';') }.flatten).to_a.sample(20)
      recommended_books = Book.where(isbn: recommended_book_isbns).order(rating_avg: :desc)

      render_success recommended_books, serializer: BookSerializer
    end

    def item_based
      render_success @book.related_books, serializer: BookSerializer
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
