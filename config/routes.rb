Rails.application.routes.draw do
  resources :products
  resources :orders, except: :destroy do
    resources :line_items
    resources :status_transitions, only: [:index, :create]
  end
end
