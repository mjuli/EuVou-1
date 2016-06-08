Rails.application.routes.draw do
  
  root 'events#index'
  
  get '/events/category/:category_id' => 'events#index' 

  resources :events do
  	resources :comments, only: [:create, :destroy]
  end
  
  resources :categories
	resources :eu_vous, only: [:create, :destroy]
  resources :reports, only: [:create, :destroy]
  
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/profile/:id' => 'users#user_show', via: [:get, :patch], :as => :user_show
  devise_for :users, :controllers => { registration: 'registration', omniauth_callbacks: 'omniauth_callbacks' }

end
