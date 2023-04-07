# frozen_string_literal: true

class Api::UsersController < Api::BaseController
  # respond_to :json
  # before_action :authenticate_request!, only: [:index]

  def index
    users = User.all
    render json: users
  end
end
