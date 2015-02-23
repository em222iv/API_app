Rails.application.routes.draw do
  root                'sessions#new'
  get    'about'   => 'users#show'
  get    'settings'=> 'users#edit'
  get    'deleteKey'=>   'users#deleteKey'
  get    'generateKey'=> 'users#generateKey'
  get    'Users' =>   'users#list'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  namespace :api do
    get    'near'   => 'event#nearby'
    resources :event,:tag,:creator,:position
  end
end

