Rails.application.routes.draw do
  get 'artists/:id' => "artists#show", :as=> "artist"

  get 'songs/search'

  get 'songs/:id'=> "songs#show", :as => "song"

  post 'songs/rate'=> "songs#rate", :as => "song_rate"

  get 'QuickDeal' => "songs#deal", :as =>"deal"

  post 'recordings/create' =>  "recordings#create" 

  get 'recordings/show_data' =>  "recordings#show_data" 

  get 'recordings/show' =>  "recordings#show" 

  get 'recordings/index' =>  "recordings#index" 

  match "recordings/destroy", to: "recordings#destroy", via: :delete
  
  devise_for :users
  authenticated :user do
    root :to => "songs#search" , :as => "authenticated_root"
  end
  root to: 'visitors#home'
  get "/about" => "visitors#about"
  get "/scroll/:scroll_id" => "users#scroll", as: "scroll"
  get '/profile' => "users#profile"
  get "/performance" => "users#performance"
  get "/headset" =>  "users#headset" 
end
