Rails.application.routes.draw do
  devise_for :users
  get 'instruments/index'
  root to: "instruments#index"
end
