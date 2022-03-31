Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :admin,skip:[:registrations,:passwords],controllers:{sessions:"admin/sessions"}

  namespace :admin do
    root to: "homes#top"
    resources :customers
    resources :items
    resources :genres
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  devise_for :customers, skip:[:passwords],controllers:{
    registrations:"customer/registrations",
    sessions:"customer/sessions"
  }

  scope module: :public do
    get "/about" => "homes#about"
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete "/cart_items/" => "cart_items#destroy_all",as:"destroy_all"
    post "/orders/confirm" => "orders#confirm"
    get "/orders/complete" => "orders#complete"
    resources :orders, only: [:new, :create, :index, :show]
    resources :customers, only: [:show, :edit, :update]
    get "/customers/mypage" => "customers#show"
    get "/customers/mypage/edit" => "customers#edit"
    patch "/customers/mypage/update" => "customers#update"
    get "/customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdraw" => "customers#withdraw"
    resources :shippings
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
