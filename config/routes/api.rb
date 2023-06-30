# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :books, only: %i[index show] do
      collection do
        get 'recently_viewed', to: 'recently_viewed_books#index'
        get 'favorites', to: 'favorite_books#index'
        get 'top_rated', to: 'books#top_rated_books'
      end

      member do
        post 'toggle_favorite', to: 'favorite_books#toggle_favorite'
        get 'related', to: 'books#related_books'
      end
    end
    resources :genres, only: %i[index show]
    resources :authors, only: %i[index show]
    resources :users, only: %i[index]

    resources :book_ratings, only: %i[index create] do
      collection do
        post '', to: 'book_ratings#create_or_update'
        get 'format', to: 'book_ratings#format'
      end
    end

    namespace :me do
      resources :books, only: %i[index]
      put 'profile', to: 'profiles#update'
    end

    scope :auth do
      get '', to: 'authentication#auth'
      post 'sign_in', to: 'authentication#sign_in'
      post 'sign_up', to: 'authentication#sign_up'
    end
  end
end
