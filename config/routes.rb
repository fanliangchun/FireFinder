Rails.application.routes.draw do
  devise_for :users
  resources :apps do
    resources :comments
  end
  root 'apps#index'

  namespace :admin do
  	resources :apps do
  		member do
  			post :publish
  			post :hide
  		end
  	end
  end

end
