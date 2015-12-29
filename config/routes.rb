Rails.application.routes.draw do
  root to: 'visitors#home'
  get "/about" => "visitors#about"
  get "/performance" => "visitors#performance"
end
