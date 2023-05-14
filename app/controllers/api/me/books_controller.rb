module Api
  module Me
    class BooksController < Api::BaseController
      before_action :authenticate_request!

      def index
        books = @current_user.books
        render_success books
      end
    end
  end
end
