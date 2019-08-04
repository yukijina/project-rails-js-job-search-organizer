Rails.application.routes.draw do
  resources :companies
  resources :users, only: [:new, :create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies, only: [:show] do
    resources :positions
  end

  resources :users, only: [:show] do
    resources :checklists, except: [:show, :new]
  end

  root 'sessions#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

#Routes for Google authentication
  get '/auth/:provider/callback', to: 'sessions#googleAuth'
  #get 'auth/failure', to: redirect('/')

  #get '*path' => redirect('/')



end
