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

  scope '(:locale)', locale: /en|ru/,
                     defaults: { locale: I18n.default_locale } do
    resources :decks do
      resources :cards
    end
  end

  resources :users, except: %i[index] do
    get 'edit_password', on: :member
    resources :decks
  end

  resources :sessions, only: %i[new create destroy]

  resources :cards do
    put 'trainer', on: :member
  end
end
