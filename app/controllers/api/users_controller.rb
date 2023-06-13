# frozen_string_literal: true

module Api
  class UsersController < Api::BaseController
    # respond_to :json
    # before_action :authenticate_request!, only: [:index]
    include Pagy::Backend
    def index
      users = User.all

      # Pagination with Pagy
      @pagy, users = pagy(users, items: params[:per_page])

      meta = { pagination:
                 {  per_page: @pagy.items,
                    total_pages: @pagy.pages,
                    total_objects: @pagy.count,
                    page: @pagy.page,
                    next_page: @pagy.next,
                    prev_page: @pagy.prev } }

      render_success users, meta:
    end
  end
end
