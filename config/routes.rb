Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  resources :users, only:[:show, :edit, :update]
  resources :movies do
    resources :comments, only: [:create, :destroy]
  end
  root :to => 'homes#top'
  get 'homes/about'
end
