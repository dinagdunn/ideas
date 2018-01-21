Rails.application.routes.draw do
  root 'users#new'

  # post "users" => "users#create"
  # post "ideas" => "ideas#create"
  post 'users/login' => 'users#login'
  delete 'users/:id' => "users#destroy"
  delete 'ideas/:id' => "ideas#destroy"
  # get 'ideas/new' => "ideas#new"
  # get "users/:id" => "users#show"
  # get "ideas/:id" => "ideas#show"
  # get "ideas" => "ideas#index"
  # get "users/new" => "users#new"
  # get "likes/new" => "likes#new"

  # post "likes" => "likes#create"
  
  resources :likes
  resources :users
  resources :ideas
end
