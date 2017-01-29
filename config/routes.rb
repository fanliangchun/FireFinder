Rails.application.routes.draw do
  devise_for :users
  resources :apps
  root 'apps#index'

  namespace :admin do
  	resources :apps
  end

end
