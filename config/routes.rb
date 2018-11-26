Rails.application.routes.draw do
  devise_for :users, :path => 'accounts'
  resources :users do
    resources :favourites, only: [:index, :create]
  end

  root to: 'menus#new'
  get 'menus/:menu_id/orders', to: "results#order", as: :order
  resources :menus, only: [:index, :create] do
    resources :results, only: [:index, :show, :create, :edit]
  end
  resources :results, only: [:update]

  resources :foods, only: [:index, :show] do
    resources :favourites, only: [:create, :destroy]
  end
end

