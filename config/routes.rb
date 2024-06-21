Rails.application.routes.draw do
  devise_for :users
  root to: "instruments#index"

  resources :instruments do
    collection do
      get :load_inspectors
    end  
    resources :inspection_items, only: [:create]
    resources :inspection_results, only: [:index, :new, :create, :show]
  end
end
