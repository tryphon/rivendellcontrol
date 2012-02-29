ActionController::Routing::Routes.draw do |map|

  map.resources :streams, :member => { :toggle => :put }
  map.resource :metadata, :controller => "metadata"

  map.resources :events
  map.resource :dashboard
  map.resources :monitorings

  map.root :controller => "welcome"
  
end
