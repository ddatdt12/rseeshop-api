# frozen_string_literal: true

module Api
  class GenresController < Api::BaseController
    include Pagy::Backend

    def index
      genres = Genre.all

      render_success genres
    end
  end
end
