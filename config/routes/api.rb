# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :books, only: %i[index show] do
      collection do
        get 'recently_viewed', to: 'recently_viewed_books#index'
        get 'favorites', to: 'favorite_books#index'
      end

      member do
        post 'toggle_favorite', to: 'favorite_books#toggle_favorite'
      end
    end
    resources :genres, only: %i[index show]
    resources :authors, only: %i[index show]
    resources :users, only: %i[index]
    resources :orders, only: %i[index show create] do
      member do
        post 'pay', to: 'orders#pay'
      end
    end

    namespace :me do
      resources :books, only: %i[index]
    end

    scope :auth do
      get '', to: 'authentication#auth'
      post 'sign_in', to: 'authentication#sign_in'
      post 'sign_up', to: 'authentication#sign_up'
    end
  end
end
