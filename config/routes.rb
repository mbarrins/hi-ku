Rails.application.routes.draw do

  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  get '/home', to: 'users#home'
  get '/haiku_history', to: 'users#haiku_history'
  get '/random_haiku', to: 'poems#random_haiku'
  get '/profile', to: 'users#show'
  get '/settings', to: 'users#settings'
  get '/my_haiku', to: 'users#my_poems'
  get '/my_liked_haiku', to: 'users#liked_poems'
  get '/my_comments', to: 'users#comments'
  get '/my_saved_haiku', to: 'users#saved_poems'
<<<<<<< HEAD
  resources :users, only: [:edit, :show, :create, :update, :destroy]
=======
  resources :users, :path => "authors", only: [:show, :edit, :create, :update, :destroy]
>>>>>>> 256e369e5f2b9bacb48fe2906e014e2904e6506b

  get 'poems/search', to: 'poems#search'
  resources :poems

  resources :comments, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :words, only: [:create]
  resources :moods, only: [:index, :show]
  resources :genres, only: [:index, :show]

  get '*path' => redirect('/') unless Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
