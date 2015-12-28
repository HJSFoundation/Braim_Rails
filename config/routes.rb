Rails.application.routes.draw do
  root to: 'visitors#index'
  get "/about" => "visitors#about"
  get "/performance" => "visitors#performance"
end
