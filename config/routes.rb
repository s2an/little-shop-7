Rails.application.routes.draw do

  namespace :admin do
     root to: "dashboard#index"
    resources :merchants, only:[:index, :show, :edit, :update]
    resources :invoices, only:[:index, :show, :edit, :update]
  end  

  # get "/merchants/:id/dashboard", to: "merchants/dashboard#show"

  resources :merchants do
    resources :dashboard
    resources :invoices, only: [:index, :show]
    resources :items, only: [:index, :show]
  end
  # get "/merchants/:merchant_id/invoices", to: "invoices#index"
  # get "/merchants/:merchant_id/invoices/:invoice_id", to: "invoices#show"
end
