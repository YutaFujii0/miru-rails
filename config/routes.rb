Rails.application.routes.draw do
  devise_for :users

  root to: 'menus#new'
  get 'menus/:menu_id/orders', to: "results#order", as: :order
  get 'foods/:food_id/results/:id', to: 'foods#show', as: :results_food_show

  resources :menus, only: [:create] do
    resources :results, only: [:index]
  end

  resources :results, only: [:update]

  resources :foods, only: [:show] do
    resources :favourites, only: [:create]
  end

  resources :favourites, only: [:index, :destroy]
end
