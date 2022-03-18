Rails.application.routes.draw do
  # get 'schedules/index'
  root to: 'schedules#index'
  resources :schedules, only: [:index, :new, :create, :show, :destroy, :edit, :update ]
end
