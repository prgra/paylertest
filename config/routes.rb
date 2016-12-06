Rails.application.routes.draw do
  resources :countries
  resources :ips
  get "/" => "ips#stats"
  post "/masscreate" => "ips#masscreate"
end
