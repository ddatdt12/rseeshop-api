# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include ApiException::Handler

    protected

    def render_success(data, meta: {}, message: 'Request success', status: :ok)
      render json: { data:, message: }.merge(meta || {}), status:
    end

    def render_error(error = 'Server Error', status = :internal_server_error)
      render json: { error: }, status:
    end

    def authenticate_request!
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      begin
        decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        @current_user = User.find(decoded[0]['user_id'])
      rescue JWT::DecodeError
        render_error('Invalid token', :unauthorized)
      end
    end

    # function to get user id from token if it exists
    def attempt_get_user_id
      return if request.headers['Authorization'].nil? || @current_user_id.present?

      header = request.headers['Authorization']
      token = header.split(' ').last if header
      begin
        decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        @current_user_id = decoded[0]['user_id']
      rescue JWT::DecodeError
        @current_user_id = nil
      end
    end
  end
end
