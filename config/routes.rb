AntimapRails::Application.routes.draw do
  
  post "csv/import" => 'csv#upload'
  
  resources :logs, :except => [:edit, :update, :create]
  root :to => "logs#index"

end