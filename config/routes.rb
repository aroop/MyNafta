ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
  	admin.resources :users
	end

  map.resources :config_values

  map.resources :certified_repositories

  map.resources :part_detail_archives

  map.resources :part_details

  map.resources :roles

  map.resources :importers

  map.resources :suppliers

  map.resources :addresses

  map.resources :users, :member => {
    :suspend => :put,
    :unsuspend => :put,
    :purge => :delete
  }

  map.resource :session

  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:code', :controller => 'users', :action => 'reset_password'
  map.account '/account', :controller => 'users', :action => 'account'

  map.home '/', :controller => 'sessions', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end