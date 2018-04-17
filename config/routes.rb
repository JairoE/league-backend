Rails.application.routes.draw do
  resources :champions, only: [:index, :show]
  # resources :user_matches
  resources :users do
    resources :matches, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/fetch_user', to: 'users#fetch_user'
  get '/users/:id/fetch_rank', to: 'users#fetch_rank'
  post '/users/sign_up', to: 'users#sign_up'
  post '/users/sign_in', to: 'users#sign_in'
  get '/matches/:id', to: 'matches#show'


end
