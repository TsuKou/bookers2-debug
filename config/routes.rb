Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  devise_for :users

  get "/home/about"=>"homes#about", as: "about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]   #応用課題3で「do ~ end」まで追加
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relation, only: [:create, :destroy]
    get "yes_follow" => "relationships#yes_follow", as: "yes_follow"
    get "no_follow" => "relatioships#no_follow", as: "no_follow"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
