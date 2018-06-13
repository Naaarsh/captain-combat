Rails.application.routes.draw do
  root 'captain_combat#show'

  resources :fighters
end
