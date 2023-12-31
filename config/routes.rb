Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      get "/markets/search", to: "market_search#index"
      get "/markets/:id/nearest_atms", to: "nearest_atms#index"
      
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end

      delete "/market_vendors", to: "market_vendors#destroy"
      resources :vendors
      resources :market_vendors

    end
  end
end
