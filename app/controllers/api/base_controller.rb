# frozen_string_literal: true

class Api::BaseController < ApplicationController
  include ApiException::Handler

  protected

  def authenticate_request!
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_user = User.find(decoded[0]['user_id'])
    rescue JWT::DecodeError
      render json: { message: 'Invalid token' }, status: :unauthorized
    end
  end
end
