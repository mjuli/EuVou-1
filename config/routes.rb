Rails.application.routes.draw do
  
  root 'events#index'
  
  get '/events/category/:category_id' => 'events#index' 

  resources :events do
  	resources :comments, only: [:create, :destroy]
  end
  
  resources :categories
  
  post '/eu_vous/create/:id' => 'eu_vous#create', as: "euvou_path"

  delete '/eu_vous/delete/:id' => 'eu_vous#destroy'
  
  post '/reports/create/:id' => 'reports#create', as: "report_path"

  delete '/reports/delete/:id' => 'reports#destroy'
  
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/profile/:id' => 'users#user_show', via: [:get, :patch], :as => :user_show

  devise_for :users, :controllers => { registration: 'registration', omniauth_callbacks: 'omniauth_callbacks' }

end
