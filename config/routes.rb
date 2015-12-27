Rails.application.routes.draw do
  root to: 'visitors#index'
  get "/about" => "visitors#about"
end
