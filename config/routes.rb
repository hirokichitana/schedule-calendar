Rails.application.routes.draw do
  devise_for :users
  # get 'schedules/index'
  root to: 'schedules#index'
  resources :schedules
  resources :users, only: :show
end
