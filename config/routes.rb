Rails.application.routes.draw do
  devise_for :admins
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      member do
        post :like, controller: 'likes', action: 'create'
      end
    end
  end
end