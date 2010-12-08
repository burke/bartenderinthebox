Bartenderinthebox::Application.routes.draw do

  resources :drinks do
    member do
      get :mix
    end 
  end 

  root :to => "drinks#index"
  
end
