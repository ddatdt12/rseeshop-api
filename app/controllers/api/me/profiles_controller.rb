# frozen_string_literal: true

module Api
  module Me
    class ProfilesController < Api::BaseController
      before_action :authenticate_request!

      def update
        if @current_user.update(user_params)
          render_success @current_user, serializer: UserSerializer
        else
          render_error @current_user.errors.full_messages.join(', ')
        end
      end

      private

      def user_params
        params.permit(:name, :email, favorite_genres: [])
      end
    end
  end
end
