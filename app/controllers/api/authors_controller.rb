# frozen_string_literal: true

module Api
  class AuthorsController < Api::BaseController
    include Pagy::Backend

    def index
      @authors = Author.all

      render_success @authors
    end
  end
end
