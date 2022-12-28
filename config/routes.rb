Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: %i[index show create] do
    resources :friends, only: %i[create], controller: :user_friends
  end
  get '/dashboard', to: 'users#show'
  get '/discover', to: 'users#discover'
  post '/discover', to: 'users#discover'

  resources :movies, only: %i[show index create] do
    resources :parties, only: %i[new create], controller: :movie_parties
  end
end
