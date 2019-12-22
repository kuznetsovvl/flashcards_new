# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  get 'signup' => 'users#new', :as => 'signup'
  get 'sessions/new'
  resources :users do
    resources :cards
  end
  resources :sessions
  resources :cards do
    put 'trainer', on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
