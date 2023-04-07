# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    scope :auth do
      post 'sign_in', to: 'authentication#sign_in'
      post 'sign_up', to: 'authentication#sign_up'
    end

    resources :users, only: %i[index]
  end

  root to: 'home#index'
end
