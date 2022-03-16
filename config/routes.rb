Rails.application.routes.draw do
  get 'schedules/index'
  root to: 'schedules#index'
  resources :schedules, only: :index
end
