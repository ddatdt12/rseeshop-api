# frozen_string_literal: true

module Api
  class UsersController < Api::BaseController
    # respond_to :json
    # before_action :authenticate_request!, only: [:index]

    def index
      users = User.all
      render_success users
    end
  end
end
