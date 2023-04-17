# frozen_string_literal: true

class Api::AuthenticationController < Api::BaseController
  before_action :authenticate_request!, only: [:auth]
  def auth
    render json: { data: @current_user }
  end

  def sign_in
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { token: generate_token(user), data: user }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end

    # rescue ActiveRecord::RecordNotFound => e
    #   render json: { error: 'Invalid email or password' }, status: :unauthorized
  end

  def sign_up
    user = User.new(user_params)

    if user.save
      render json: { token: generate_token(user), data: user }
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def generate_token(user)
    payload = { user_id: user.id }
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

end
