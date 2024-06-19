Rails.application.routes.draw do
  devise_for :users
  root to: "instruments#index"

  resources :instruments do
    resources :inspection_items, only: [:create]
    resources :inspection_results, only: [:new, :create, :index]
    collection do
      get :load_inspectors
    end  
  end
end
