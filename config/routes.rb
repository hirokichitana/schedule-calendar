Rails.application.routes.draw do
  devise_for :users
  # get 'schedules/index'
  root to: 'schedules#index'
  resources :schedules, only: [:index, :new, :create, :show, :destroy, :edit, :update ]
end
