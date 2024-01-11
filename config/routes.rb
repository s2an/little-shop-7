Rails.application.routes.draw do
  
  get "/", to: "application#welcome"

  namespace :admin do
    root to: "dashboard#index"
    resources :merchants, only:[:index, :show, :edit, :update]
    resources :invoices, only:[:index, :show, :edit, :update]
  end 

  resources :merchants do
    resources :dashboard
    resources :invoices, only: [:index, :show]
    resources :items, param: :item_id, only: [:index, :show, :new, :create, :edit, :update]
    resources :invoice_items, only: [:update]
  end
end
