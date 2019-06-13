Rails.application.routes.draw do
  resources :comments, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :poems
  resources :moods, only: [:index, :show]
  resources :genres, only: [:index, :show]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
