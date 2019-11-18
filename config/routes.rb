# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  put 'cards/:id', to: 'cards#trainer'
  root 'welcome#index'
  resources :cards do
  	put 'trainer', on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
