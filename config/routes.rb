Rails.application.routes.draw do
	devise_for :users
	resources :about
	resources :welcome  do
	end
		
	resources :apps do
		member do
			post :upvote
		end
		resources :comments
		collection do
			get :search
		end
	end
	root 'welcome#index'

	namespace :admin do
		resources :apps do
			member do
				post :publish
				post :hide
			end
		end
		end
end
