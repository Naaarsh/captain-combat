Rails.application.routes.draw do
  root 'captain_combat#show'

  resources :fighters
  resources :fights, only: [:new, :create, :show, :index]
end
