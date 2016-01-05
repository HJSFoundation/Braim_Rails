Rails.application.routes.draw do
  get 'songs/search'

  get 'songs/show'

  devise_for :users
  authenticated :user do
    root :to => "users#profile" , :as => "authenticated_root"
  end
  root to: 'visitors#home'
  get "/about" => "visitors#about"

  get '/profile' => "users#profile"
  get "/performance" => "users#performance"
  get "/headset" =>  "users#headset" 
end
