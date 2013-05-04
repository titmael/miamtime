Miamtime::Application.routes.draw do
	resources :surveys, :except => [:delete]

  match 'survey/:hash_url' => 'Surveys#show', :as => 'show_survey'
  match 'vote/:hash_url/:option' => 'Votes#create', :as => 'create_vote'
  get 'cities/search' => 'Surveys#search_cities', :as => 'search_cities'

  post 'edit/login' => 'Surveys#edit_login', :as => 'edit_login_survey'

  root :to => "home#index"
end
