Tracks::Application.routes.draw do
  get "calendar/index"

  resources :meal_dishes

  resources :meals

  resources :colleagues

  resources :spots

  resources :dishes

  resources :drops do
    collection do
      post 'multi_ops'
    end
  end

  resources :projects do
    member do
    end

    collection do
      post 'close_checked'
      post 'reopen_checked'
    end
  end

  resources :expense_details do
    member do
    end

    collection do
      get 'new_v2'
      post 'multi_ops'
    end
  end

  resources :labor_claims do
    member do
    end

    collection do
      get 'new_v2'
      post 'multi_ops'
      post 'batch_update'
    end
  end

  resources :working_locations do
    member do
    end

    collection do
      get 'new_v2'
      post 'multi_ops'
    end
  end

  # resources :stay_nights
  resources :stay_nights do
    member do

    end

    collection do
      post 'multi_ops'
      post 'batch_update'
    end
  end

  resources :payment_types
  resources :expense_types

  resources :cities
  resources :hotels
  resources :sites

  resources :clients

  resources :weathers

  resources :segments

  #resources :cities do
#    resources :sites, only: ["index_nested", "new_nested", "edit_nested", "create_nested", "update_nested", "destroy_nested"]
#    resources :sites, only: [:index]
#    resources :sites do
#      get :index_nested, on: :collection
#      get :new_nested, on: :member
#    end
#  end

# simple nested
  match "/cities/:city_id/sites", :to => "sites#index_nested", via: :get, as: :city_sites
  match "/clients/:client_id/projects", :to => "projects#index_nested", via: :get, as: :client_projects
  match "/drops/:drop_id/segments", :to => "segments#index_nested", via: :get, as: :drop_segments
  match "/drops/:drop_id/meals", :to => "meals#index_nested", via: :get, as: :drop_meals
  match "/meals/:meal_id/dishes", :to => "meal_dishes#index_nested", via: :get, as: :meal_dish_list

  # get sites based on changed city
  get 'get_sites' => 'working_locations#get_sites'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'expense_details#index'

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

  # testing ones
  get "go_single/go"
  get 'simple_form' => 'go_single#TestForm'
  get 'simple_copy' => 'go_single#TestCopy'
  get 'bundle_dup' => 'go_single#BundleDupSelection'
  post 'go_bundle_copy' => 'go_single#TestBundleDup', as: :go_bundle_copy

end
