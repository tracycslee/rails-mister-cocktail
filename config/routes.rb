Rails.application.routes.draw do
  get 'doses/create'
  get 'doses/new'
  get 'ingredients/create'
  get 'cocktails/index'
  get 'cocktails/show'
  get 'cocktails/new'
  get 'cocktails/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "cocktails#index"
  resources :cocktails, only: [:index, :show, :new, :create] do
    resources :ingredients, only: [:create]
    resources :doses, only: [:create, :new]
  end
  resources :doses, only: [:destroy]
end
