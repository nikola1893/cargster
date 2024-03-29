Rails.application.routes.draw do
  devise_for :users, controllers: {confirmations: 'users/confirmations'}
  root to: "pages#home"
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"
  resources :loads, only: [:show, :index, :new, :create, :edit, :update]
  resources :trucks, only: [:show, :index, :new, :create, :edit, :update]
  get "profile", to: "pages#profile"
  get "all_trucks", to: "pages#all_trucks"
  get "all_loads", to: "pages#all_loads"
  get '/truck_templates', to: 'trucks#truck_templates'
  get '/load_templates', to: 'loads#load_templates'
  get "/privacy", to: "pages#privacy"
  get "/terms", to: "pages#terms"
  patch '/trucks/:id/change_status', to: 'trucks#change_status', as: 'change_truck_status'
  patch '/loads/:id/change_status', to: 'loads#change_status', as: 'change_load_status'
end
