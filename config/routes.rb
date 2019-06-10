Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'signup' => 'users#new'
  #delete 'logout'  => 'devise/sessions#destroy'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  
  root 'static_pages#home'

  resources :students
<<<<<<< HEAD
  get '/preferiti',    to: 'students#preferiti',    as: 'student_preferiti'
  
  get '/pdf', to: 'documents#pdf'
  post '/document_txt', to: 'documents#txt'
  
  resources :documents do
	resources :likes
	resources :report
	post 'report',  to: 'report#create', as: 'reportpost'
	post 'dislike', to: 'likes#dislike', as: 'mydislike'
	post 'like',    to: 'likes#like',    as: 'mylike'
	get  'pdf',     to: 'documents#pdf'
	put  'delete',     to: 'documents#delete'
	
  end
  
  resources :documents do
	resources :preferiti
  end
=======
>>>>>>> c63412f323eb3b6124db28c340a232abef7923b1
end
