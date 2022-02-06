Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search/serches" => "searches#search"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments,only: [:create, :destroy]
    resource :favorites, only: [:create,:destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy,]
    get :followers,on: :member
    get :followeds,on: :member
  end

  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]

  resources :groups, only: [:new, :create, :edit, :update, :show, :index] do
    get :join, on: :member
    get :out, on: :member
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
