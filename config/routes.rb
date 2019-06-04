Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'signup' => 'users#new'
  #delete 'logout'  => 'devise/sessions#destroy'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  
  root 'static_pages#home'

  resources :students
end
