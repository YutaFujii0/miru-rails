Rails.application.routes.draw do
  devise_for :users
  root to: 'menus#new'
  get 'menus/:id/results', to: "results#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :menus, only: [:index, :create] do 
    resources :results, only: [:order]
  end
  resources :foods, only: [:show]

end
