Rails.application.routes.draw do
  root 			'visitors#index'
  get 			'/about',	         to: 'visitors#about'
  get 			'/show',	         to: 'visitors#show'
  get    		'/login',          to: 'sessions#new'
  post   		'/login',          to: 'sessions#create'
  get	 		  '/logout',         to: 'sessions#destroy'

  resources 		:visitors, only:[:index, :show]
  resources 		:posts

  resources 		:users do
    member do
      get :confirm_email
    end
  end

  resources :posts, :shallow => true do 
    resources :comments
  end
end
