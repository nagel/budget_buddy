Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do

    #Users
    get "/users" => "users#index"
    post "/users" => "users#create"
    get "/users/:id" => "users#show"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    #Session
    post "/sessions" => "sessions#create"

    #Categories
    get "/categories" => "categories#index"
    post "/categories" => "categories#create"
    get "/categories/:id" => "categories#show"
    patch "/categories/:id" => "categories#update"
    delete "/categories/:id" => "categories#destroy"

    #vendors
    get "/plaid_categories" => "plaid_categories#index"
    post "/plaid_categories" => "plaid_categories#create"
    get "/plaid_categories/:id" => "plaid_categories#show"
    patch "/plaid_categories/:id" => "plaid_categories#update"
    delete "/plaid_categories/:id" => "plaid_categories#destroy"

    #Items
    get "/items" => "items#index"
    post "/items" => "items#create"
    get "/items/:id" => "items#show"
    patch "/items/:id" => "items#update"
    delete "/items/:id" => "items#destroy"

    #Accounts
    get "/accounts" => "accounts#index"
    post "/accounts" => "accounts#create"
    get "/accounts/:id" => "accounts#show"
    patch "/accounts/:id" => "accounts#update"
    delete "/accounts/:id" => "accounts#destroy"

    #Transactions
    get "/transactions" => "transactions#index"
    post "/transactions" => "transactions#create"
    get "/transactions/:id" => "transactions#show"
    patch "/transactions/:id" => "transactions#update"
    delete "/transactions/:id" => "transactions#destroy"

    #Plaid
    post "/get_access_token" => "plaid#accesstoken"

  end

end
