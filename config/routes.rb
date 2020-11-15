Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :users, only:[:show, :edit, :update]
  resources :movies
  root :to => 'homes#top'
  get 'homes/about'
end
