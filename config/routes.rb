Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get '/users', to: "user#index", as: 'users'
  get '/user', to: "user#create_user_view"
  post '/user', to: "user#create_user"
  get '/user/:id', to: "user#destroy_user", as: 'destroy_user'
  get '/user/edit/:id', to: "user#edit_user", as: 'edit_user'
  post '/user/edit/:id', to: "user#update_user", as: 'update_user'
  get '/user/profile/:id', to: "wallet#profile_view",  as: 'profile_user'
  post '/user/wallet/transaction/:userid', to: "wallet#make_transaction", as: 'credit_transaction' 

  # API Routes
  post '/api/signin', to: "authenticator_api#signin"
  get '/api/wallet/:userid', to: "wallet_api#get_wallet_by_user" 
  get '/api/transactions', to: "wallet_api#get_wallet_by_date"
  put '/api/debit/wallet/:userid', to: "wallet_api#debit_wallet"  
  put '/api/credit/wallet/:userid', to: "wallet_api#credit_wallet" 
end
