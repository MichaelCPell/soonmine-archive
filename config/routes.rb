Soonmine::Application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations"}

  devise_scope :user do
    get "users/complete_email", :to => "users#purgatory", :as => "user_complete_email"
    get "users/new_from_email", to: "users/registrations#new_from_email", as: "new_from_email"
  end
  

  resources :contacts do
    collection do 
      get "add_from_google", to: "contacts#add_from_google", as: "add_google"
    end
  end
  resources :users, only: [:show, :index]
  resources :products
  resources :reminders

  

  get "/about", to: "static_pages#about"
  get "/share", to: "static_pages#share"
  get "/welcome", to: "static_pages#welcome"
  get "/how_it_works", to: "static_pages#how_it_works"
  get "/contact_us", to: "static_pages#contact_us"
  get "/privacy", to: "static_pages#privacy"
  get "/copyright", to: "static_pages#copyright"
  get "/team", to: "static_pages#team"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'static_pages#welcome'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
