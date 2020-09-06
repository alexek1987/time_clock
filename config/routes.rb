Rails.application.routes.draw do
  devise_for :users
   namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :jobs, only: [ :index, :show, :update, :create ]


      get 'jobs/:id/new-time-entry', to: 'jobs#new_time_entry'
    end
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
