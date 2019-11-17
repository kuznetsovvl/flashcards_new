Rails.application.routes.draw do
  get 'welcome/index'
  put 'cards/:id', to: 'cards#trainer'
  root 'welcome#index'
  resources :cards 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
