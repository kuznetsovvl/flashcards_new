# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  delete 'logout' => 'sessions#destroy', as: :logout
  post 'login' => 'sessions#new', as: :login
  post 'signup' => 'users#new', as: :signup
  get 'sessions/new'

  scope '/oauth' do
    post 'callback' => 'oauths#callback'
    get 'callback' => 'oauths#callback'
    get ':provider' => 'oauths#oauth', as: :auth_at_provider
  end

  resources :users do
    resources :cards
  end
  resources :sessions, only: %i[new create destroy]
  resources :cards do
    put 'trainer', on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
