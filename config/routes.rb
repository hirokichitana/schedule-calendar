Rails.application.routes.draw do
  devise_for :users
  # get 'schedules/index'
  root to: 'schedules#index'
  resources :schedules do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: :show
end
