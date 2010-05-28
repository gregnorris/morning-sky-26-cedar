ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
  
  
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new" # first page user sees is the login page
  #map.root :controller => :recipients
  
  map.resources :recipients, :collection => { :show_map => :get } do |recipient|
    recipient.resources :deliveries, :member => { :delivery_sheet => :get } do |delivery|
      delivery.resources :delivered_items
    end
  end
  
  # to allow for top level index view
  map.resources :deliveries, :member => { :add_to_worksheet => :put }
  map.resources :donor_pickups, :member => { :add_to_worksheet => :put }
  
  # TODO: remove :member => { :add_to_worksheet => :put } 
  map.resources :donors, :member => { :add_to_worksheet => :put } do |donor|
    donor.resources :donor_items
    donor.resources :donor_pickups, :member => { :delivery_sheet => :get } do |pickup|
      pickup.resources :pickedup_items
    end
  end
  
  map.resources :items
  map.resources :case_workers
  map.resources :organizations
  map.resources :reports, :member => { :deliveries_stats => :get }
  
  map.resources :users
  map.resource :account, :controller => "users"
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :daily_worksheets, :member => { :reorder => :get, :print_worksheet => :get } do |daily_worksheet|
    map.resources :daily_deliveries
  end
  
end
