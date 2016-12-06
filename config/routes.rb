Rails.application.routes.draw do
  resources :countries
  resources :ips
  #get "/masscreate" => "ips#masscreate"
  post "/masscreate" => "ips#masscreate"
end
