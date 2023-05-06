# frozen_string_literal: true

Rails.application.routes.draw do
  draw :api

  root to: 'home#index'
end
