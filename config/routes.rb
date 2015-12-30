Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root :to => "users#profile" , :as => "authenticated_root"
  end
  root to: 'visitors#home'
  get 'users/profile'
  get "/about" => "visitors#about"
  get "/performance" => "visitors#performance"
end
