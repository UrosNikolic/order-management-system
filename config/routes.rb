Rails.application.routes.draw do
  resources :products
  resources :orders, except: :destroy do
    resources :line_items
    resources :status_transitions, only: [:show, :create]
  end
end
