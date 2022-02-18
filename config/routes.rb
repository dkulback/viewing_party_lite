Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: %i[show create]
  get '/dashboard', to: 'users#show'
  get '/discover', to: 'users#discover'
  post '/discover', to: 'users#discover'

  resources :movies, only: %i[show index create], controller: :users_movies do
    resources :parties, only: %i[new create], controller: :users_movies_parties
  end
end
