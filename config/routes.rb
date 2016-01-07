Rails.application.routes.draw do
  get 'artists/:id' => "artists#show", :as=> "artist"

  get 'songs/search'

  get 'songs/:id'=> "songs#show", :as => "song"

  devise_for :users
  authenticated :user do
    root :to => "songs#search" , :as => "authenticated_root"
  end
  root to: 'visitors#home'
  get "/about" => "visitors#about"

  get '/profile' => "users#profile"
  get "/performance" => "users#performance"
  get "/headset" =>  "users#headset" 
end
