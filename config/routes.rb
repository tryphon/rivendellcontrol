RivendellControl::Application.routes.draw do
  resource :dashboard
  root :to => 'welcome#index'
end
