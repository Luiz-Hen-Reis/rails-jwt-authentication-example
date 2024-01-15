Rails.application.routes.draw do
  resources :musics
  resources :users, only: [:create]
  post 'login', to: "users#login"
end
