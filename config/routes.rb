Rails.application.routes.draw do
  devise_for :users
  resources :welcome
  resources :about
  resources :apps do
    resources :comments
    collection do
      get :search
    end

    member do
      post 'upvote'
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
