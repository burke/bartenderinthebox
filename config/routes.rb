ActionController::Routing::Routes.draw do |map|
  map.resources :reservoirs

  map.resources :ingredients

  map.resources :drinks

  map.resources :drinks

  map.resources :drinks

  map.resources :reservoirs

  map.resources :ingredients

  map.root :controller => 'drinks'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
