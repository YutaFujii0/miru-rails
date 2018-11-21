Rails.application.routes.draw do
  devise_for :users
  root to: 'menus#new'
  get 'menus/:menu_id/orders', to: "results#order"
  resources :menus, only: [:index, :create] do
    resources :results, only: [:index, :show, :create]
  end
  resources :foods, only: [:show]

end
