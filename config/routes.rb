Rails.application.routes.draw do
  devise_for :users
  root to: "instruments#index"

  resources :instruments do
    collection do
      get :load_inspectors
    end
    resources :inspection_items, only: [:create]
    resources :inspection_results, only: [:index, :new, :create] do
      member do
        patch :approve
      end
    end
  end
  resources :inspection_results, only: [:show]
  resources :users, only: [:index, :show]
  resources :reservations, only: [:index, :new, :show, :create]
end
