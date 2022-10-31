Rails.application.routes.draw do
  root 'home#index'
  devise_for :users


  resources :phones, except: [:update, :edit, :new, :create] do
    patch :reset
    patch :approve
    patch :ship
    patch :arrive
    patch :evaluate
    patch :send_analysis
    patch :accept_analysis
    patch :fix
    patch :await_shipment
    patch :complete 
  end
end
