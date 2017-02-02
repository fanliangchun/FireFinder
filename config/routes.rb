Rails.application.routes.draw do
	devise_for :users
	resources :about
	resources :welcome
	root 'apps#index'
		
	resources :apps do
		member do
			post :upvote
		end
		resources :comments
		collection do
			get :search
		end
	end


	namespace :admin do
		resources :apps do
			member do
				post :publish
				post :hide
			end
		end
		end
end
