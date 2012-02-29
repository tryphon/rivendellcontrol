ActionController::Routing::Routes.draw do |map|
  map.resource :network
  map.resource :save_point
  map.resource :input
  map.resource :icecast
  map.resource :support
  map.resource :log
  map.resource :ssh, :controller => :ssh

  map.resources :releases, :member => { :download => :get, :install => :get, :description => :get }
end
