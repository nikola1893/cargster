Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :loads, only: [:show, :new, :create, :index, :edit, :update]
  resources :trucks, only: [:show, :new, :create, :index, :edit, :update]

  get "profile", to: "pages#profile"
  get 'trucks/:id/again', to: 'trucks#again', as: 'again'
  get '/truck_templates', to: 'trucks#truck_templates'
  patch ':id/change_status', to: 'trucks#change_status', as: 'change_truck_status'
  patch ':id/change_status', to: 'loads#change_status', as: 'change_load_status'
  # Defines the root path route ("/")
  # root "articles#index"
end
