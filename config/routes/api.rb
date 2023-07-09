# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :books, only: %i[index show] do
      collection do
        get 'recently_viewed', to: 'recently_viewed_books#index'
        get 'recommendated', to: 'books#recommendated_books'
        get 'top_rated', to: 'books#top_rated_books'
      end

      member do
        get 'related-genres', to: 'books#get_books_by_favorate_genres'
        post 'toggle_favorite', to: 'favorite_books#toggle_favorite'
        get 'related', to: 'books#related_books'
        get 'item_based', to: 'books#item_based'
      end
    end

    get 'new_user_books', to: 'books#get_books_by_favorate_genres'

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
      put 'profile', to: 'profiles#update'
    end

    scope :auth do
      get '', to: 'authentication#auth'
      post 'sign_in', to: 'authentication#sign_in'
      post 'sign_up', to: 'authentication#sign_up'
    end
  end
end
