# frozen_string_literal: true

module Api
  class AuthenticationController < Api::BaseController
    before_action :authenticate_request!, only: [:auth]
    def auth
      render_success @current_user, serializer: UserSerializer
    end

    def sign_in
      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        render_success user, message: 'Sign in successfully', meta: { token: generate_token(user) }, serializer: UserSerializer
      else
        render_error('Invalid email or password', :unauthorized)
      end
    end

    def sign_up
      user = User.new(user_params)

      if user.save
        render_success user, message: 'Sign up successfully', status: :created, meta: { token: generate_token(user) }, serializer: UserSerializer
      else
        render_error(user.errors.full_messages.to_sentence, :unprocessable_entity)
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
end
