Rails.application.routes.draw do
  #resources :checklists
  #resources :positions
  resources :companies
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :companies, only: [:show] do
    resources :positions, only: [:index, :new, :create, :show, :edit, :update]
  end

  resources :users, only: [:show] do
    resources :checklists, only: [:index]
  end

  root 'sessions#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
