Rails.application.routes.draw do
  devise_for :users
  root to: 'menus#new'
  get 'menus/:menu_id/orders', to: "results#order"
  resources :menus, only: [:index, :create] do
    resources :results, only: [:index, :show, :create, :edit, :update]
  end
  resources :foods, only: [:index, :show]

end
