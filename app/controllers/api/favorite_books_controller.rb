# frozen_string_literal: true

module Api
  class FavoriteBooksController < Api::BaseController
    before_action :authenticate_request!, only: %i[index toggle_favorite]
    before_action :set_book, only: [:toggle_favorite]

    def index
      favorite_books = FavoriteBook.all.order('updated_at DESC').limit(10)
                                   .where(user_id: @current_user.id).with_book.map(&:book)

      render_success favorite_books
    end

    def toggle_favorite
      favorite_book = FavoriteBook.find_by(book_id: @book.id, user_id: @current_user.id)
      if favorite_book.present?
        favorite_book.destroy
        render_success nil, message: 'Removed from favorites'
      else
        FavoriteBook.create(user_id: @current_user.id, book_id: @book.id)
        render_success nil, message: 'Added to favorites'
      end
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end
  end
end
