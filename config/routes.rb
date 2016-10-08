Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :campaigns, shallow: true, only: [:new, :create, :show, :index, :destroy] do
    resources :pledges, only: [:create, :destroy] do
      resources :payments, only: [:new, :create]
    end
    resources :publishings, only: [:create]
  end

  resources :users, only: [:new, :create, :index]
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  root "campaigns#index"
end
