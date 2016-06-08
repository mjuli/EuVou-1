Rails.application.routes.draw do
  
  root 'events#index'
  
  get '/events/category/:category_id' => 'events#index' 

  resources :events do
  	resources :comments, only: [:create, :destroy]
  end
  
  resources :categories
	
  post '/euvou/:attended_event_id' => 'eu_vous#create' 

  delete '/euvou/:attended_event_id' => 'eu_vous#destroy' 
  
  post '/report/:reported_event_id' => 'reports#create' 

  delete '/report/:reported_event_id' => 'reports#destroy' 
  
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/profile/:id' => 'users#user_show', via: [:get, :patch], :as => :user_show
  devise_for :users, :controllers => { registration: 'registration', omniauth_callbacks: 'omniauth_callbacks' }

end
