Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  #session routes
  post "/signIn(.:format)" => "sessions#sign_in", as: :new_session
  post "/signUp(.:format)" => "sessions#sign_up", as: :new_account

  namespace :api do
    namespace :v1 do
      #Categories
      get 'categories/' => 'categories#index'
      get 'categories/:id' => 'categories#show'
      # get 'categories/:name' => 'categories#searched'
      post 'categories/new(.:format)' => 'categories#create', as: :new_category
      # patch "/categories/update/:name(.:format)" => "categories#modify", as: :update_category
      patch "/categories/update/:id(.:format)" => "categories#modify", as: :update_category

       #Products
       get 'products/' => 'products#index'
       get 'products/:id' => 'products#show'
       post 'products/new(.:format)' => 'products#create', as: :new_product
       patch "/products/update/:id(.:format)" => "products#modify", as: :update_product
    end
  end

  namespace :api do
    namespace :v2 do      
       #Categories
       get 'categories/' => 'categories#index', as: :all_categories
       get 'categories/:id' => 'categories#show', as: :category_by_id
       post 'categories/new(.:format)' => 'categories#create', as: :create_category
       patch "/categories/modify/:id(.:format)" => "categories#modify", as: :modify_category

       #Products
       get 'products/' => 'products#index', as: :all_products
       get 'products/:id' => 'products#show', as: :products_by_id
       get 'products/category/:id' => 'products#show_group', as: :products_by_category
       post 'products/new(.:format)' => 'products#create', as: :create_product
       patch "/products/modify/:id(.:format)" => "products#modify", as: :modify_product

       #Transactions
       get 'transactions/' => 'transactions#index', as: :all_transactions
       post 'transactions/new(.:format)' => 'transactions#create', as: :create_transaction
       patch 'transactions/delivered/:id' => 'transactions#delivered', as: :delivered_transaction
    end
  end

  root "sales#index"
end
