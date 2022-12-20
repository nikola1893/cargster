Rails.application.routes.draw do
  devise_for :users
  root to: "pages#todays_loads"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :loads, only: [:show, :new, :create, :index, :edit, :update]
  resources :trucks, only: [:show, :new, :create, :index, :edit, :update]
  get "profile", to: "pages#profile"
  get "todays_trucks", to: "pages#todays_trucks"
  get "todays_loads", to: "pages#todays_loads"
  get '/truck_templates', to: 'trucks#truck_templates'
  get '/load_templates', to: 'loads#load_templates'
  get '/trucks/:id/truck_suggestions', to: 'trucks#truck_suggestions', as: 'truck_suggestions'
  get '/loads/:id/load_suggestions', to: 'loads#load_suggestions', as: 'load_suggestions'
  patch '/trucks/:id/change_status', to: 'trucks#change_status', as: 'change_truck_status'
  patch '/loads/:id/change_status', to: 'loads#change_status', as: 'change_load_status'
end
