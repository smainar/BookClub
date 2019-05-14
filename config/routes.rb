Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/books', to: 'books#index'
  get '/', to: 'welcome#index'
  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:new, :create]
  end
  resources :authors, only: [:show]
  resources :reviews, only: [:destroy]
  resources :users, only: [:show] do
    resources :reviews, only: [:destroy]
  end
end
