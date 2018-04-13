Rails.application.routes.draw do
  resources :users do
    resources :stats, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/fetch_user', to: 'users#fetch_user'
  post '/users/sign_up', to: 'users#sign_up'
  post '/users/sign_in', to: 'users#sign_in'

end
