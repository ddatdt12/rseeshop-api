# frozen_string_literal: true

module Api
  class BooksController < Api::BaseController
    include Pagy::Backend
    before_action :attempt_get_user_id, only: [:show]

    def index
      books = Book.all

      # Filter by genre
      # if params[:genre].present?
      #   @books = @books.where(genre: params[:genre])
      # end

      # Filter by year of publication
      # if params[:year].present?
      #   @books = @books.where(year: params[:year])
      # end

      # Filter by author
      # if params[:author].present?
      #   @books = @books.where(author: params[:author])
      # end

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
      render_success books, meta:
    end

    def show
      book = Book.find_by_id(params[:id])

      if book.present?
        # Update recently viewed books
        if @current_user_id.present? && @current_user_id.present?
          RecentlyViewedBooks::UpdateService.call(user_id: @current_user_id,
                                                  book_id: book.id)
        end

        render_success book
      else
        render_error 'Book not found', :not_found
      end
    end
  end
end
