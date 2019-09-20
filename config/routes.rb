Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup/", to: "users#new"
    get "/login/", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :categories, only: :show do
      resources :products, only: :show
    end
    resources :users, only: [:show, :create]
    resources :carts, only: [:create, :index, :destroy]
    resources :orders, only: [:index, :new, :create]
  end
end
