Rails.application.routes.draw do
  get 'all_users/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'posts#index'
resources :posts do	
	# resources :comments
	member do 
		post :like
		post :unlike
		get :all_likes
		post :comment
		post :remove_comment
		get :user_profile
	end
	collection do		
		get :my_post
	end
	
end
# resources :likes do
# 	collection do
# 		get :all_likes
# 	end
# end
resources :friendships do
	member do
		post :accept
		post :reject
	end
	collection do 
		get :myfriends
	end
end
resources :friendrequests
resource :friquests


end
