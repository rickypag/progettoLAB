Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'signup' => 'users#new'
  #delete 'logout'  => 'devise/sessions#destroy'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  
  root 'static_pages#home'

  resources :students
  get '/preferiti',    to: 'students#preferiti',    as: 'student_preferiti'
  
  resources :documents do
	resources :likes
	post 'dislike', to: 'likes#dislike', as: 'mydislike'
	post 'like',    to: 'likes#like',    as: 'mylike'
  end
  
  resources :documents do
	resources :preferiti
  end
end
