Miamtime::Application.routes.draw do
	resources :surveys

  root :to => "home#index"
end
